part of '../calendar.dart';

/// Displays the days of a given month and allows choosing a day.
///
/// The days are arranged in a rectangular grid with one column for each day of
/// the week.
class _DayPicker extends StatefulWidget {
  /// Creates a day picker.
  const _DayPicker({
    required this.style,
    required this.config,
    required this.displayedMonth,
    required this.selectedDates,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  /// The calendar configurations
  final CalendarConfig config;

  /// The style of the calendar.
  final CalendarStyle style;

  /// The currently selected dates.
  ///
  /// Selected dates are highlighted in the picker.
  final List<DateTime> selectedDates;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  @override
  _DayPickerState createState() => _DayPickerState();
}

class _DayPickerState extends State<_DayPicker> {
  /// List of [FocusNode]s, one for each day of the month.
  late List<FocusNode> _dayFocusNodes;

  @override
  void initState() {
    super.initState();
    final int daysInMonth = DateUtils.getDaysInMonth(
        widget.displayedMonth.year, widget.displayedMonth.month);
    _dayFocusNodes = List<FocusNode>.generate(
      daysInMonth,
      (int index) =>
          FocusNode(skipTraversal: true, debugLabel: 'Day ${index + 1}'),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check to see if the focused date is in this month, if so focus it.
    final DateTime? focusedDate = _FocusedDate.maybeOf(context);
    if (focusedDate != null &&
        DateUtils.isSameMonth(widget.displayedMonth, focusedDate)) {
      _dayFocusNodes[focusedDate.day - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final FocusNode node in _dayFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  List<Widget> _dayHeaders(
      TextStyle? headerStyle, MaterialLocalizations localizations) {
    final List<Widget> result = <Widget>[];
    final weekdays = widget.style.weekdayLabels ?? localizations.narrowWeekdays;
    final firstDayOfWeek =
        widget.config.firstDayOfWeek ?? localizations.firstDayOfWeekIndex;
    assert(firstDayOfWeek >= 0 && firstDayOfWeek <= 6,
        'firstDayOfWeek must between 0 and 6');
    for (int i = firstDayOfWeek; true; i = (i + 1) % 7) {
      final String weekday = weekdays[i];
      result.add(ExcludeSemantics(
        child: Center(
          child: Text(
            weekday,
            style: widget.style.weekdayLabelTextStyle ?? headerStyle,
          ),
        ),
      ));
      if (i == (firstDayOfWeek - 1) % 7) break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = widget.style;
    final config = widget.config;
    final ColorScheme colorScheme = theme.colorScheme;
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle? headerStyle = textTheme.bodySmall?.apply(
      color: colorScheme.onSurface.withOpacity(0.60),
    );
    final TextStyle dayStyle = textTheme.bodySmall!;
    final Color enabledDayColor = colorScheme.onSurface.withOpacity(0.87);
    final Color disabledDayColor = colorScheme.onSurface.withOpacity(0.38);
    final Color selectedDayColor = colorScheme.onPrimary;
    final Color selectedDayBackground = colorScheme.primary;
    final Color todayColor = colorScheme.primary;

    final int year = widget.displayedMonth.year;
    final int month = widget.displayedMonth.month;

    final int daysInMonth = DateUtils.getDaysInMonth(year, month);
    final int dayOffset = getMonthFirstDayOffset(year, month,
        config.firstDayOfWeek ?? localizations.firstDayOfWeekIndex);

    final List<Widget> dayItems = _dayHeaders(headerStyle, localizations);
    // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
    // a leap year.
    int day = -dayOffset;
    while (day < daysInMonth) {
      day++;
      if (day < 1) {
        dayItems.add(Container());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        final bool isDisabled = dayToBuild.isAfter(config.lastDate) ||
            dayToBuild.isBefore(config.firstDate) ||
            !(config.selectableDayPredicate?.call(dayToBuild) ?? true);
        final bool isSelectedDay =
            widget.selectedDates.any((d) => DateUtils.isSameDay(d, dayToBuild));

        final bool isToday =
            DateUtils.isSameDay(config.currentDate, dayToBuild);

        Decoration? decoration;
        Color dayColor = enabledDayColor;
        if (isSelectedDay) {
          // The selected day gets a circle background highlight, and a
          // contrasting text color.
          dayColor = selectedDayColor;
          decoration = ShapeDecoration(
            color: style.selectedDayHighlightColor ?? selectedDayBackground,
            shape: style.dayShapeBorder ?? const CircleBorder(),
          );
        } else if (isDisabled) {
          dayColor = disabledDayColor;
        } else if (isToday) {
          // The current day gets a different text color and a circle stroke
          // border.
          dayColor = style.selectedDayHighlightColor ?? todayColor;
          decoration = ShapeDecoration(
            shape: style.dayShapeBorder ??
                CircleBorder(
                  side: BorderSide(color: dayColor),
                ),
          );
        }

        var customDayTextStyle =
            config.dayTextStylePredicate?.call(date: dayToBuild) ??
                style.dayTextStyle;

        if (isToday && style.todayTextStyle != null) {
          customDayTextStyle = style.todayTextStyle;
        }

        if (isDisabled) {
          customDayTextStyle = customDayTextStyle?.copyWith(
            color: disabledDayColor,
            fontWeight: FontWeight.normal,
          );
          if (style.disabledDayTextStyle != null) {
            customDayTextStyle = style.disabledDayTextStyle;
          }
        }

        final isFullySelectedRangePicker =
            config.calendarType == CalendarType.range &&
                widget.selectedDates.length == 2;
        var isDateInBetweenRangePickerSelectedDates = false;

        if (isFullySelectedRangePicker) {
          final startDate = DateUtils.dateOnly(widget.selectedDates[0]);
          final endDate = DateUtils.dateOnly(widget.selectedDates[1]);

          isDateInBetweenRangePickerSelectedDates =
              !(dayToBuild.isBefore(startDate) ||
                      dayToBuild.isAfter(endDate)) &&
                  !DateUtils.isSameDay(startDate, endDate);
        }

        if (isDateInBetweenRangePickerSelectedDates &&
            widget.style.selectedRangeDayTextStyle != null) {
          customDayTextStyle = widget.style.selectedRangeDayTextStyle;
        }

        if (isSelectedDay) {
          customDayTextStyle = widget.style.selectedDayTextStyle;
        }

        final dayTextStyle =
            customDayTextStyle ?? dayStyle.apply(color: dayColor);

        Widget dayWidget = config.dayBuilder?.call(
              date: dayToBuild,
              textStyle: dayTextStyle,
              decoration: decoration,
              isSelected: isSelectedDay,
              isDisabled: isDisabled,
              isToday: isToday,
            ) ??
            _buildDefaultDayWidgetContent(
              decoration,
              localizations,
              day,
              dayTextStyle,
            );

        if (isDateInBetweenRangePickerSelectedDates) {
          final rangePickerIncludedDayDecoration = BoxDecoration(
            color: style.selectedRangeHighlightColor ??
                (style.selectedDayHighlightColor ?? selectedDayBackground)
                    .withOpacity(0.15),
          );

          if (DateUtils.isSameDay(
            DateUtils.dateOnly(widget.selectedDates[0]),
            dayToBuild,
          )) {
            dayWidget = Stack(
              children: [
                Row(children: [
                  const Spacer(),
                  Expanded(
                    child: Container(
                      decoration: rangePickerIncludedDayDecoration,
                    ),
                  ),
                ]),
                dayWidget,
              ],
            );
          } else if (DateUtils.isSameDay(
            DateUtils.dateOnly(widget.selectedDates[1]),
            dayToBuild,
          )) {
            dayWidget = Stack(
              children: [
                Row(children: [
                  Expanded(
                    child: Container(
                      decoration: rangePickerIncludedDayDecoration,
                    ),
                  ),
                  const Spacer(),
                ]),
                dayWidget,
              ],
            );
          } else {
            dayWidget = Stack(
              children: [
                Container(
                  decoration: rangePickerIncludedDayDecoration,
                ),
                dayWidget,
              ],
            );
          }
        }

        dayWidget = Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: dayWidget,
        );

        if (isDisabled) {
          dayWidget = ExcludeSemantics(
            child: dayWidget,
          );
        } else {
          dayWidget = InkResponse(
            focusNode: _dayFocusNodes[day - 1],
            onTap: () => widget.onChanged(dayToBuild),
            radius: style.splashRadius,
            splashColor: theme.splashColor,
            splashFactory: theme.splashFactory,
            customBorder: style.dayShapeBorder,
            highlightShape: style.dayShapeBorder != null
                ? BoxShape.rectangle
                : BoxShape.circle,
            highlightColor: theme.highlightColor,
            child: Semantics(
              // We want the day of month to be spoken first irrespective of the
              // locale-specific preferences or TextDirection. This is because
              // an accessibility user is more likely to be interested in the
              // day of month before the rest of the date, as they are looking
              // for the day of month. To do that we prepend day of month to the
              // formatted full date.
              label:
                  '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}',
              selected: isSelectedDay,
              excludeSemantics: true,
              child: dayWidget,
            ),
          );
        }

        dayItems.add(dayWidget);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _monthPickerHorizontalPadding,
      ),
      child: GridView.custom(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        gridDelegate: _DayPickerGridDelegate(
          style: style,
        ),
        childrenDelegate: SliverChildListDelegate(
          dayItems,
          addRepaintBoundaries: false,
        ),
      ),
    );
  }

  Widget _buildDefaultDayWidgetContent(
    Decoration? decoration,
    MaterialLocalizations localizations,
    int day,
    TextStyle dayTextStyle,
  ) {
    return Row(
      children: [
        const Spacer(),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: decoration,
            child: Center(
              child: Text(
                localizations.formatDecimal(day),
                style: dayTextStyle,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate({
    required this.style,
  });

  final CalendarStyle style;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double tileHeight = math.min(
      style.dayCellHeight,
      constraints.viewportMainAxisExtent / (_kMaxDayPickerRowCount + 1),
    );
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}
