# Roamio's Fork of CalendarDatePicker2

## Particular to this version
- Controls over the dimensions of the calendar.
- Improved theming.

## Original Config Options (all are preserved)

### Config options

### For CalendarDatePicker2 widget

| Argument                | Type                           | Description                                              |
| ----------------------- | ------------------------------ | -------------------------------------------------------- |
| config                  | CalendarDatePicker2Config      | Calendar UI related configurations                       |
| value                   | List\<DateTime?\>              | The selected [DateTime]s that the picker should display. |
| onValueChanged          | ValueChanged<List<DateTime?>>? | Called when the selected dates changed                   |
| displayedMonthDate      | DateTime?                      | Date to control calendar displayed month                 |
| onDisplayedMonthChanged | ValueChanged\<DateTime\>?      | The initially displayed view of the calendar picker      |

### For CalendarDatePicker2Config:

| Option                      | Type                           | Description                                                                         |
| --------------------------- | ------------------------------ | ----------------------------------------------------------------------------------- |
| calendarType                | CalendarDatePicker2Type?       | Calendar picker type, has 3 values: single, multi, range                            |
| firstDate                   | DateTime?                      | The earliest allowable DateTime user can select                                     |
| lastDate                    | DateTime?                      | The latest allowable DateTime user can select                                       |
| currentDate                 | DateTime?                      | The DateTime representing today which will be outlined in calendar                  |
| calendarViewMode            | DatePickerMode?                | The initially displayed view of the calendar picker                                 |
| weekdayLabels               | List\<String\>?                | Custom weekday labels, should starts with Sunday                                    |
| weekdayLabelTextStyle       | TextStyle?                     | Custom text style for weekday labels                                                |
| firstDayOfWeek              | int?                           | Index of the first day of week, where 0 points to Sunday, and 6 points to Saturday. |
| controlsHeight              | double?                        | Custom height for calendar control toggle's height                                  |
| lastMonthIcon               | Widget?                        | Custom icon for last month button control                                           |
| nextMonthIcon               | Widget?                        | Custom icon for next month button control                                           |
| controlsTextStyle           | TextStyle?                     | Custom text style for calendar mode toggle control                                  |
| dayTextStyle                | TextStyle?                     | Custom text style for calendar day text                                             |
| selectedDayTextStyle        | TextStyle?                     | Custom text style for selected calendar day text                                    |
| selectedRangeDayTextStyle   | TextStyle?                     | Custom text style for selected range calendar day(s)                                |
| selectedDayHighlightColor   | Color?                         | The highlight color selected day                                                    |
| selectedRangeHighlightColor | Color?                         | The highlight color for day(s) included in the selected range                       |
| disabledDayTextStyle        | TextStyle?                     | Custom text style for disabled calendar day(s)                                      |
| todayTextStyle              | TextStyle?                     | Custom text style for current calendar day                                          |
| yearTextStyle               | TextStyle?                     | Custom text style for years list                                                    |
| selectedYearTextStyle       | TextStyle?                     | Custom text style for selected year                                                 |
| dayBorderRadius             | BorderRadius?                  | Custom border radius for day indicator                                              |
| yearBorderRadius            | BorderRadius?                  | Custom border radius for year indicator                                             |
| selectableDayPredicate      | SelectableDayPredicate?        | Function to provide full control over which dates in the calendar can be selected   |
| dayTextStylePredicate       | CalendarDayTextStylePredicate? | Function to provide full control over calendar days text style                      |
| dayBuilder                  | CalendarDayBuilder?            | Function to provide full control over day widget UI                                 |
| yearBuilder                 | CalendarYearBuilder?           | Function to provide full control over year widget UI                                |
| disableModePicker           | bool?                          | Flag to disable mode picker and hide the toggle icon                                |
| centerAlignModePicker       | bool?                          | Flag to centralize year and month text label in controls                            |
| customModePickerIcon        | Widget?                        | Custom icon for the mode picker button icon                                         |
| modePickerTextHandler       | CalendarModePickerTextHandler? | Function to control mode picker displayed text                                      |
| rangeBidirectional          | bool                           | Flag to enable selecting dates range also in reverse-chronological order            |

### In addition to the configurations above, CalendarDatePicker2WithActionButtonsConfig has 9 extra options

| Option                       | Type        | Description                                     |
| ---------------------------- | ----------- | ----------------------------------------------- |
| gapBetweenCalendarAndButtons | double?     | The gap between calendar and action buttons     |
| cancelButtonTextStyle        | TextStyle?  | Text style for cancel button                    |
| cancelButton                 | Widget?     | Custom cancel button                            |
| okButtonTextStyle            | TextStyle?  | Text style for ok button                        |
| okButton                     | Widget?     | Custom ok button                                |
| openedFromDialog             | bool?       | Is the calendar opened from dialog              |
| closeDialogOnCancelTapped    | bool?       | Close dialog after user taps the CANCEL button  |
| closeDialogOnOkTapped        | bool?       | Close dialog after user taps the OK button      |
| buttonPadding                | EdgeInsets? | Custom wrapping padding for Ok & Cancel buttons |

### Custom UI

By using the configs above, you could make your own custom calendar picker as your need.

<img width="300" alt="image" src="https://user-images.githubusercontent.com/17869748/223992571-f153515d-170d-48f6-afce-84f59f58940b.png"> <img width="300" alt="image" src="https://user-images.githubusercontent.com/17869748/223992976-5539a3af-6409-4983-958b-ca927a9d714f.png">

```dart
CalendarDatePicker2WithActionButtons(
  config: CalendarDatePicker2WithActionButtonsConfig(
    firstDayOfWeek: 1,
    calendarType: CalendarDatePicker2Type.range,
    selectedDayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    selectedDayHighlightColor: Colors.purple[800],
    centerAlignModePicker: true,
    customModePickerIcon: SizedBox(),
    dayBuilder: _yourDayBuilder,
    yearBuilder: _yourYearBuilder,
  ),
  value: _dates,
  onValueChanged: (dates) => _dates = dates,
);
```

## Multi-language support

This package has multi-language supports. To enable it, add your `Locale` into the wrapping `MaterialApp`:

```dart
MaterialApp(
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
  supportedLocales: const [
    Locale('en', ''),
    Locale('zh', ''),
    Locale('ru', ''),
    Locale('es', ''),
    Locale('hi', ''),
  ],
  ...
);
```

| <img width="232" alt="image" src="https://user-images.githubusercontent.com/17869748/227443635-604afb00-9d26-4e2b-ae66-5839ac25347f.png"> | <img width="232" alt="image" src="https://user-images.githubusercontent.com/17869748/227442622-1e17ec84-9593-4587-b54a-506aeb020d32.png"> | <img width="232" alt="image" src="https://user-images.githubusercontent.com/17869748/227443327-89ce40ba-e661-4006-ba42-dfcc3ae27d43.png"> | <img width="232" alt="image" src="https://user-images.githubusercontent.com/17869748/227444732-bd137b1d-9941-4542-89bc-6f63407e422d.png"> |
| :---------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                 **中文**                                                                  |                                                                **русский**                                                                |                                                                **español**                                                                |                                                                 **हिंदी**                                                                 |

## Contributions

Feel free to contribute to this project. 🍺 Pull requests are welcome!

There are some tips before creating a PR:

- Please always create an issue/feature before raising a PR
- Please always create a minimum reproducible example for an issue
- Please use the official [Dart Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) as your formatter or use `flutter format . -l 80` if you are not using VS Code
- Please keep your changes to its minimum needed scope (avoid introducing unrelated changes)
- Please follow this git commit [convention](https://www.conventionalcommits.org/en/v1.0.0-beta.2/) by adding `feat:` or `fix:` to your PR commit
