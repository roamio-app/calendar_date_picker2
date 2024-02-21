import 'package:flutter/material.dart';

enum CalendarType {
  single,
  multi,

  /// Allows selecting a range of two dates.
  ///
  /// See also [CalendarConfig.rangeBidirectional].
  range,
}

typedef CalendarDayTextStylePredicate = TextStyle? Function({
  required DateTime date,
});

typedef CalendarDayBuilder = Widget? Function({
  required DateTime date,
  TextStyle? textStyle,
  Decoration? decoration,
  bool? isSelected,
  bool? isDisabled,
  bool? isToday,
});

typedef CalendarYearBuilder = Widget? Function({
  required int year,
  TextStyle? textStyle,
  Decoration? decoration,
  bool? isSelected,
  bool? isDisabled,
  bool? isCurrentYear,
});

typedef CalendarButtonBuilder = Widget Function({
  required VoidCallback? onPressed,
  required String? tooltip,
  required Widget? child,
});

typedef CalendarModePickerTextHandler = String? Function({
  required DateTime monthDate,
});

class CalendarConfig {
  CalendarConfig({
    this.calendarType = CalendarType.single,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    this.calendarViewMode = DatePickerMode.day,
    this.firstDayOfWeek,
    this.lastMonthIcon,
    this.nextMonthIcon,
    this.selectableDayPredicate,
    this.dayTextStylePredicate,
    this.dayBuilder,
    this.yearBuilder,
    this.disableModePicker = false,
    this.centerAlignModePicker = false,
    this.customModePickerIcon,
    this.modePickerTextHandler,
    this.rangeBidirectional = false,
    this.navigationButtonBuilder,
  })  : firstDate = DateUtils.dateOnly(firstDate ?? DateTime(1970)),
        lastDate =
            DateUtils.dateOnly(lastDate ?? DateTime(DateTime.now().year + 50)),
        currentDate = currentDate ?? DateUtils.dateOnly(DateTime.now());

  /// The enabled date picker mode
  final CalendarType calendarType;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The [DateTime] representing today. It will be highlighted in the day grid.
  final DateTime currentDate;

  /// The initially displayed view of the calendar picker.
  final DatePickerMode calendarViewMode;

  /// Index of the first day of week, where 0 points to Sunday, and 6 points to Saturday.
  final int? firstDayOfWeek;

  /// Custom icon for last month button control
  final Widget? lastMonthIcon;

  /// Custom icon for next month button control
  final Widget? nextMonthIcon;

  /// Function to provide full control over which dates in the calendar can be selected.
  final SelectableDayPredicate? selectableDayPredicate;

  /// Function to provide full control over calendar days text style
  final CalendarDayTextStylePredicate? dayTextStylePredicate;

  /// Function to provide full control over day widget UI
  final CalendarDayBuilder? dayBuilder;

  /// Function to provide full control over year widget UI
  final CalendarYearBuilder? yearBuilder;

  /// Flag to disable mode picker and hide the mode toggle button icon
  final bool disableModePicker;

  /// Flag to centralize year and month text label in controls
  final bool centerAlignModePicker;

  /// Custom icon for the mode picker button icon
  final Widget? customModePickerIcon;

  /// Function to control mode picker displayed text.
  ///
  final CalendarModePickerTextHandler? modePickerTextHandler;

  /// Whether the range selection can be also made in reverse-chronological
  /// order.
  /// Only applicable when [calendarType] is [CalendarType.range].
  final bool rangeBidirectional;

  /// Builder for previous and next month buttons.
  ///
  final CalendarButtonBuilder? navigationButtonBuilder;

  CalendarConfig copyWith({
    CalendarType? calendarType,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    DatePickerMode? calendarViewMode,
    int? firstDayOfWeek,
    Widget? lastMonthIcon,
    Widget? nextMonthIcon,
    SelectableDayPredicate? selectableDayPredicate,
    CalendarDayTextStylePredicate? dayTextStylePredicate,
    CalendarDayBuilder? dayBuilder,
    CalendarYearBuilder? yearBuilder,
    bool? disableModePicker,
    bool? centerAlignModePicker,
    Widget? customModePickerIcon,
    CalendarModePickerTextHandler? modePickerTextHandler,
    bool? rangeBidirectional,
    CalendarButtonBuilder? navigationButtonBuilder,
  }) {
    return CalendarConfig(
      calendarType: calendarType ?? this.calendarType,
      firstDate: DateUtils.dateOnly(firstDate ?? this.firstDate),
      lastDate: DateUtils.dateOnly(lastDate ?? this.lastDate),
      currentDate: currentDate ?? this.currentDate,
      calendarViewMode: calendarViewMode ?? this.calendarViewMode,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      lastMonthIcon: lastMonthIcon ?? this.lastMonthIcon,
      nextMonthIcon: nextMonthIcon ?? this.nextMonthIcon,
      selectableDayPredicate:
          selectableDayPredicate ?? this.selectableDayPredicate,
      dayTextStylePredicate:
          dayTextStylePredicate ?? this.dayTextStylePredicate,
      dayBuilder: dayBuilder ?? this.dayBuilder,
      yearBuilder: yearBuilder ?? this.yearBuilder,
      disableModePicker: disableModePicker ?? this.disableModePicker,
      centerAlignModePicker:
          centerAlignModePicker ?? this.centerAlignModePicker,
      customModePickerIcon: customModePickerIcon ?? this.customModePickerIcon,
      modePickerTextHandler:
          modePickerTextHandler ?? this.modePickerTextHandler,
      rangeBidirectional: rangeBidirectional ?? this.rangeBidirectional,
      navigationButtonBuilder:
          navigationButtonBuilder ?? this.navigationButtonBuilder,
    );
  }
}

class CalendarWithActionButtonsConfig extends CalendarConfig {
  CalendarWithActionButtonsConfig({
    super.calendarType,
    super.firstDate,
    super.lastDate,
    super.currentDate,
    super.calendarViewMode,
    super.firstDayOfWeek,
    super.lastMonthIcon,
    super.nextMonthIcon,
    super.selectableDayPredicate,
    super.dayTextStylePredicate,
    super.dayBuilder,
    super.yearBuilder,
    super.disableModePicker,
    super.centerAlignModePicker,
    super.customModePickerIcon,
    super.modePickerTextHandler,
    super.rangeBidirectional = false,
    super.navigationButtonBuilder,
    this.cancelButton,
    this.okButton,
    this.openedFromDialog,
    this.closeDialogOnCancelTapped,
    this.closeDialogOnOkTapped,
  });

  /// Custom cancel button
  final Widget? cancelButton;

  /// Custom ok button
  final Widget? okButton;

  /// Is the calendar opened from dialog
  final bool? openedFromDialog;

  /// If the dialog should be closed when user taps the CANCEL button
  final bool? closeDialogOnCancelTapped;

  /// If the dialog should be closed when user taps the OK button
  final bool? closeDialogOnOkTapped;

  @override
  CalendarWithActionButtonsConfig copyWith({
    CalendarType? calendarType,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    DatePickerMode? calendarViewMode,
    int? firstDayOfWeek,
    Widget? lastMonthIcon,
    Widget? nextMonthIcon,
    BorderRadius? dayBorderRadius,
    BorderRadius? yearBorderRadius,
    SelectableDayPredicate? selectableDayPredicate,
    CalendarDayTextStylePredicate? dayTextStylePredicate,
    CalendarDayBuilder? dayBuilder,
    CalendarYearBuilder? yearBuilder,
    bool? disableModePicker,
    bool? centerAlignModePicker,
    Widget? customModePickerIcon,
    CalendarModePickerTextHandler? modePickerTextHandler,
    bool? rangeBidirectional,
    double? gapBetweenCalendarAndButtons,
    TextStyle? cancelButtonTextStyle,
    Widget? cancelButton,
    TextStyle? okButtonTextStyle,
    Widget? okButton,
    bool? openedFromDialog,
    bool? closeDialogOnCancelTapped,
    bool? closeDialogOnOkTapped,
    EdgeInsets? buttonPadding,
    CalendarButtonBuilder? navigationButtonBuilder,
  }) {
    return CalendarWithActionButtonsConfig(
      calendarType: calendarType ?? this.calendarType,
      firstDate: DateUtils.dateOnly(firstDate ?? this.firstDate),
      lastDate: DateUtils.dateOnly(lastDate ?? this.lastDate),
      currentDate: currentDate ?? this.currentDate,
      calendarViewMode: calendarViewMode ?? this.calendarViewMode,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      lastMonthIcon: lastMonthIcon ?? this.lastMonthIcon,
      nextMonthIcon: nextMonthIcon ?? this.nextMonthIcon,
      selectableDayPredicate:
          selectableDayPredicate ?? this.selectableDayPredicate,
      dayTextStylePredicate:
          dayTextStylePredicate ?? this.dayTextStylePredicate,
      dayBuilder: dayBuilder ?? this.dayBuilder,
      yearBuilder: yearBuilder ?? this.yearBuilder,
      disableModePicker: disableModePicker ?? this.disableModePicker,
      centerAlignModePicker:
          centerAlignModePicker ?? this.centerAlignModePicker,
      customModePickerIcon: customModePickerIcon ?? this.customModePickerIcon,
      modePickerTextHandler:
          modePickerTextHandler ?? this.modePickerTextHandler,
      rangeBidirectional: rangeBidirectional ?? this.rangeBidirectional,
      okButton: okButton ?? this.okButton,
      openedFromDialog: openedFromDialog ?? this.openedFromDialog,
      closeDialogOnCancelTapped:
          closeDialogOnCancelTapped ?? this.closeDialogOnCancelTapped,
      closeDialogOnOkTapped:
          closeDialogOnOkTapped ?? this.closeDialogOnOkTapped,
      navigationButtonBuilder: navigationButtonBuilder ?? this.navigationButtonBuilder,
    );
  }
}
