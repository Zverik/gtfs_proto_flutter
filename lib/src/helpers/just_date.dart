import 'package:gtfs_proto_flutter/src/helpers/just_time.dart';

class JustDate implements Comparable<JustDate> {
  final int year;
  final int month;
  final int day;
  final int _value;

  JustDate(this.year, this.month, this.day, [int? value]) : _value = value ?? daysSince1970(year, month, day);

  factory JustDate.fromDateTime(DateTime date) =>
      JustDate(date.year, date.month, date.day);

  factory JustDate.now() => JustDate.fromDateTime(DateTime.now());

  DateTime toDateTime([JustTime? time]) {
    return DateTime(
      year,
      month,
      day,
      time?.hour ?? 0,
      time?.minute ?? 0,
      time?.second ?? 0,
    );
  }

  /// Returns the weekday. 0 for Monday ... 6 for Sunday.
  int get weekday => (_value + 3) % 7; // 1970-01-01 is a Thursday

  @override
  String toString() => '$year-$month-$day';

  @override
  int get hashCode => _value;

  @override
  bool operator ==(Object other) => other is JustDate && other._value == _value;

  @override
  int compareTo(JustDate other) => _value.compareTo(other._value);

  int toInt() => _value;

  JustDate plusDays(int days) => JustDate.fromInt(_value + days);

  JustDate minusDays(int days) => JustDate.fromInt(_value - days);

  int operator -(JustDate other) => _value - other._value;

  factory JustDate.fromInt(int value) {
    int origValue = value;

    int year = 1970;
    while (value >= 365) {
      int daysInYear = _isLeapYear(year) ? 366 : 365;
      if (value < daysInYear) break;
      value -= daysInYear;
      year += 1;
    }

    int month = 1;
    while (value > 0) {
      int daysInMonth = _daysInMonth(month, year);
      if (value < daysInMonth) break;
      value -= daysInMonth;
      month += 1;
    }

    return JustDate(year, month, value + 1, origValue);
  }

  /// Calculates how many days passed from 1 January 1970.
  static int daysSince1970(int year, int month, int day) {
    int result = day - 1;
    for (int m = 1; m < month; m++) {
      result += _daysInMonth(m, year);
    }
    for (int y = 1970; y < year; y++) {
      result += _isLeapYear(y) ? 366 : 365;
    }
    return result;
  }

  static bool _isLeapYear(int year) {
    if (year % 400 == 0) return true;
    if (year % 100 == 0) return false;
    if (year % 4 == 0) return true;
    return false;
  }

  static int _daysInMonth(int month, int year) {
    if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    } else if (month == 2) {
      return _isLeapYear(year) ? 29 : 28;
    } else {
      return 31;
    }
  }

  bool operator >(Object other) => compareTo(other as JustDate) > 0;
  bool operator <(Object other) => compareTo(other as JustDate) < 0;
  bool operator >=(Object other) => compareTo(other as JustDate) >= 0;
  bool operator <=(Object other) => compareTo(other as JustDate) <= 0;
}
