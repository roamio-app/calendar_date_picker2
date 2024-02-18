import 'package:flutter/material.dart';

class CalendarStyle {
  const CalendarStyle({
    this.weekdayLabels,
    this.weekdayLabelTextStyle,
    this.controlsTextStyle,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.selectedRangeDayTextStyle,
    this.disabledDayTextStyle,
    this.todayTextStyle,
    this.yearTextStyle,
    this.selectedYearTextStyle,
    this.dayBorderRadius,
    this.yearBorderRadius,
    this.selectedDayHighlightColor,
    this.selectedRangeHighlightColor,
    this.controlsHeight = 52.0,
    this.dayCellHeight = 40.0,
    this.cancelButtonTextStyle,
    this.okButtonTextStyle,
    this.buttonPadding,
    this.gapBetweenCalendarAndButtons = 8.0,
    this.splashFactory = InkRipple.splashFactory,
    this.splashRadius = 24.0,
    this.yearPickerRowHeight = 52.0,
    this.yearPickerRowSpacing = 8.0,
    this.yearPickerPadding = 16.0,
  });

  /// Custom weekday labels for the current locale, MUST starts from Sunday
  /// Examples:
  ///
  /// - US English: S, M, T, W, T, F, S
  /// - Russian: вс, пн, вт, ср, чт, пт, сб - notice that the list begins with
  ///   вс (Sunday) even though the first day of week for Russian is Monday.
  ///
  final List<String>? weekdayLabels;

  /// Custom text style for weekday labels.
  ///
  final TextStyle? weekdayLabelTextStyle;

  /// Custom text style for calendar controls.
  ///
  final TextStyle? controlsTextStyle;

  /// Custom text style for calendar days.
  ///
  final TextStyle? dayTextStyle;

  /// Custom text style for selected day(s).
  ///
  final TextStyle? selectedDayTextStyle;

  /// Custom text style for selected range day(s).
  ///
  final TextStyle? selectedRangeDayTextStyle;

  /// Custom text style for disabled day(s).
  ///
  final TextStyle? disabledDayTextStyle;

  /// Custom text style for today's date.
  ///
  final TextStyle? todayTextStyle;

  /// Custom text style for year labels.
  ///
  final TextStyle? yearTextStyle;

  /// Custom text style for selected year label.
  ///
  final TextStyle? selectedYearTextStyle;

  /// Text style for cancel button.
  ///
  /// Only applicable when the config is [CalendarWithActionButtonsConfig].
  ///
  final TextStyle? cancelButtonTextStyle;

  /// Text style for ok button.
  ///
  /// Only applicable when the config is [CalendarWithActionButtonsConfig].
  ///
  final TextStyle? okButtonTextStyle;

  /// Custom wrapping padding for Ok & Cancel buttons.
  ///
  /// Only applicable when the config is [CalendarWithActionButtonsConfig].
  ///
  final EdgeInsets? buttonPadding;

  /// The gap between calendar and action buttons.
  ///
  /// Only applicable when the config is [CalendarWithActionButtonsConfig].
  ///
  final double? gapBetweenCalendarAndButtons;

  /// Custom border radius for calendar days.
  ///
  final BorderRadius? dayBorderRadius;

  /// Custom border radius for year labels.
  ///
  final BorderRadius? yearBorderRadius;

  /// Custom highlight color for selected day(s).
  ///
  final Color? selectedDayHighlightColor;

  /// The highlight color for day(s) included in the selected range.
  ///
  /// Only applicable when [calendarType] is [CalendarType.range].
  ///
  final Color? selectedRangeHighlightColor;

  /// The height of the controls section.
  ///
  /// Default is 52.0.
  ///
  final double controlsHeight;

  /// The size of the day cells.
  ///
  /// Defaults to 40.0.
  ///
  final double dayCellHeight;

  /// Splash Factory of the [InkResponse] widget that responds to tap.
  ///
  final InteractiveInkFeatureFactory? splashFactory;

  /// The splash radius of the [InkResponse] widget that responds to tap.
  ///
  final double splashRadius;

  /// The height of the year picker row.
  ///
  final double yearPickerRowHeight;

  /// The spacing between year picker rows.
  ///
  final double yearPickerRowSpacing;

  /// The padding of the year picker.
  ///
  final double yearPickerPadding;

  CalendarStyle copyWith({
    List<String>? weekdayLabels,
    TextStyle? weekdayLabelTextStyle,
    TextStyle? dayTextStyle,
    TextStyle? selectedDayTextStyle,
    TextStyle? selectedRangeDayTextStyle,
    TextStyle? disabledDayTextStyle,
    TextStyle? todayTextStyle,
    TextStyle? yearTextStyle,
    TextStyle? selectedYearTextStyle,
    BorderRadius? dayBorderRadius,
    BorderRadius? yearBorderRadius,
    Color? selectedDayHighlightColor,
    Color? selectedRangeHighlightColor,
    double? controlsHeight,
    double? dayCellHeight,
  }) {
    return CalendarStyle(
      weekdayLabels: weekdayLabels ?? this.weekdayLabels,
      weekdayLabelTextStyle:
          weekdayLabelTextStyle ?? this.weekdayLabelTextStyle,
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      selectedDayTextStyle: selectedDayTextStyle ?? this.selectedDayTextStyle,
      selectedRangeDayTextStyle:
          selectedRangeDayTextStyle ?? this.selectedRangeDayTextStyle,
      disabledDayTextStyle: disabledDayTextStyle ?? this.disabledDayTextStyle,
      todayTextStyle: todayTextStyle ?? this.todayTextStyle,
      yearTextStyle: yearTextStyle ?? this.yearTextStyle,
      selectedYearTextStyle:
          selectedYearTextStyle ?? this.selectedYearTextStyle,
      dayBorderRadius: dayBorderRadius ?? this.dayBorderRadius,
      yearBorderRadius: yearBorderRadius ?? this.yearBorderRadius,
      selectedDayHighlightColor:
          selectedDayHighlightColor ?? this.selectedDayHighlightColor,
      selectedRangeHighlightColor:
          selectedRangeHighlightColor ?? this.selectedRangeHighlightColor,
      controlsHeight: controlsHeight ?? this.controlsHeight,
      dayCellHeight: dayCellHeight ?? this.dayCellHeight,
    );
  }
}
