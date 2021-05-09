import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Calendar Widget
class CalendarWidget extends StatelessWidget {
  final ValueChanged<DateTime>? onDaySelect;

  /// Jan - Dec
  final List<String> monthLabels;

  /// Mon - Sun
  final List<String> dayLabels;

  /// Main Width of Widget
  final double width;

  /// Main Decoration
  final BoxDecoration mainDecoration;

  /// Main Padding
  final EdgeInsets mainPadding;

  /// Left And Right Arrow Icons
  final Icon _leftArrow, _rightArrow;

  final TextStyle headerTitleStyle;

  /// Constructor
  /// Please use One of the given factory methods
  CalendarWidget(
      this.width,
      this.monthLabels,
      this.mainDecoration,
      this.mainPadding,
      this._leftArrow,
      this._rightArrow,
      this.onDaySelect,
      this.dayLabels,
      this.headerTitleStyle);

  factory CalendarWidget.build(
      {List<String>? monthLabels,
      List<String>? dayLabels,
      double width = 300,
      BoxDecoration? mainDecoration,
      EdgeInsets? mainPadding,
      Icon? leftArrow,
      Icon? rightArrow,
      ValueChanged<DateTime>? onDaySelect,
      TextStyle? headerTitleStyle}) {
    return CalendarWidget(
        width,
        monthLabels ??
            [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "Mai",
              "Jun",
              "Jul",
              "Aug",
              "Oct",
              "Sep",
              "Nov",
              "Dec"
            ],
        mainDecoration ??
            BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 6,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
                borderRadius: BorderRadius.circular(20)),
        mainPadding ?? EdgeInsets.all(16),
        leftArrow ??
            Icon(
              CupertinoIcons.left_chevron,
              color: Colors.white,
              size: 14,
            ),
        rightArrow ??
            Icon(
              CupertinoIcons.right_chevron,
              color: Colors.white,
              size: 14,
            ),
        onDaySelect,
        dayLabels ?? ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
        headerTitleStyle ?? TextStyle(color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = DateTime.now();
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      List<_CalendarItem> dates = _calculateDates(currentDate);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              width: width,
              padding: mainPadding,
              decoration: mainDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(currentDate, stateSetter),
                  Container(
                    alignment: Alignment.center,
                    child: GridView.count(
                      crossAxisCount: 7,
                      children: dates.map(
                        (_CalendarItem value) {
                          return GestureDetector(
                            child: buildItem(value, selectedDate),
                            onTap: value.isDate()
                                ? () {
                                    selectedDate = value.getDate();
                                    stateSetter(() {});
                                    if (onDaySelect != null) {
                                      onDaySelect!(selectedDate);
                                    }
                                  }
                                : null,
                            behavior: HitTestBehavior.opaque,
                          );
                        },
                      ).toList(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  )
                ],
              ))
        ],
      );
    });
  }

  /// Builds Calendar Header
  Widget _buildHeader(DateTime currentDate, StateSetter stateSetter) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: _leftArrow,
            onPressed: () {
              int month = currentDate.month;
              int year = currentDate.year;
              month = currentDate.month - 1;
              year = currentDate.year;
              if (month < 1) {
                year--;
                month = 12;
              }
              currentDate = new DateTime(year, month, 1);
              stateSetter(() {});
            }),
        Container(
          child: Text(
            currentDate.year.toString() +
                " " +
                monthLabels[currentDate.month - 1],
            style: headerTitleStyle,
          ),
        ),
        IconButton(
            icon: _rightArrow,
            onPressed: () {
              int month = currentDate.month;
              int year = currentDate.year;
              month = currentDate.month + 1;
              year = currentDate.year;
              if (month > 12) {
                year++;
                month = 1;
              }
              currentDate = new DateTime(year, month, 1);
              stateSetter(() {});
            }),
      ],
    );
  }

  /// Calculate The Selected Day
  bool isSelected(_CalendarItem item, DateTime selectedDate) {
    if (selectedDate.year != item.getDate().year) {
      return false;
    }
    if (selectedDate.month != item.getDate().month) {
      return false;
    }
    if (selectedDate.day != item.getDate().day) {
      return false;
    }
    return true;
  }

  /// Calculate The Current Day
  bool isToday(_CalendarItem item) {
    DateTime today = DateTime.now();
    if (today.year != item.getDate().year) {
      return false;
    }
    if (today.month != item.getDate().month) {
      return false;
    }
    if (today.day != item.getDate().day) {
      return false;
    }
    return true;
  }

  /// Builds The Calendar Item
  Widget buildItem(_CalendarItem item, DateTime selectedDate) {
    if (!item.isDate()) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          item.dayTag,
          style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontWeight: FontWeight.normal,
              fontSize: 12),
        ),
      );
    }

    return CalendarItemWidget(
        isSelected(item, selectedDate), isToday(item), item.getDate());
  }

  /// Calculate The Calendar
  List<_CalendarItem> _calculateDates(DateTime dateTime) {
    List<_CalendarItem> result = [];
    for (String tmp in dayLabels) {
      result.add(_CalendarItem(null, tmp));
    }
    DateTime firstDayThisMonth = new DateTime(dateTime.year, dateTime.month, 1);
    DateTime firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    int days = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    for (int i = firstDayThisMonth.day; i <= days; i++) {
      result.add(
          _CalendarItem(new DateTime(dateTime.year, dateTime.month, i), ""));
    }
    return result;
  }
}

class _CalendarItem {
  final DateTime? dateTime;
  final String dayTag;
  _CalendarItem(this.dateTime, this.dayTag);

  DateTime getDate() {
    return dateTime!;
  }

  /// is Date Item
  bool isDate() {
    return dayTag.isEmpty;
  }

  /// is Day Label
  bool isDayLabel() {
    return dayTag.isNotEmpty;
  }
}

class CalendarItemWidget extends StatelessWidget {
  final bool isSelected;

  final bool isToday;
  final DateTime dateTime;

  CalendarItemWidget(this.isSelected, this.isToday, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withAlpha(100)
              : Colors.white.withAlpha(0),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        dateTime.day.toString(),
        style: TextStyle(
            fontSize: 14,
            color: isToday || isSelected
                ? Colors.white
                : Colors.white.withAlpha(140),
            fontWeight:
                isToday || isSelected ? FontWeight.bold : FontWeight.normal),
      ),
      alignment: Alignment.center,
    );
  }
}
