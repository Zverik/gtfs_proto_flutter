class JustTime implements Comparable<JustTime> {
  static const kMaxValue = 24 * 3600;

  final int hour;
  final int minute;
  final int second;

  const JustTime(this.hour, this.minute, this.second);

  factory JustTime.fromDateTime(DateTime dt) =>
      JustTime(dt.hour, dt.minute, dt.second);

  factory JustTime.now() => JustTime.fromDateTime(DateTime.now());

  factory JustTime.fromInt(int value) {
    if (value >= kMaxValue) value = value % kMaxValue;
    while (value < 0) value += kMaxValue;
    return JustTime((value / 3600).floor(), (value / 60).floor() % 60, value % 60);
  }

  int toInt() => hour * 3600 + minute * 60 + second;

  DateTime toDateTime([DateTime? date]) {
    date ??= DateTime.now();
    return DateTime(date.year, date.month, date.day, hour, minute, second);
  }

  JustTime plusSeconds(int seconds) => JustTime.fromInt(toInt() + seconds);

  JustTime minusSeconds(int seconds) => JustTime.fromInt(toInt() - seconds);

  int operator -(JustTime other) => toInt() - other.toInt();

  @override
  String toString() => '$hour:$minute:$second';

  @override
  int get hashCode => Object.hash(hour, minute, second);

  @override
  bool operator ==(Object other) =>
      other is JustTime &&
      other.hour == hour &&
      other.minute == minute &&
      other.second == second;

  @override
  int compareTo(JustTime other) {
    if (other.hour != hour) return hour.compareTo(other.hour);
    if (other.minute != minute) return minute.compareTo(other.minute);
    return second.compareTo(other.second);
  }

  bool operator >(Object other) => compareTo(other as JustTime) > 0;
  bool operator <(Object other) => compareTo(other as JustTime) < 0;
  bool operator >=(Object other) => compareTo(other as JustTime) >= 0;
  bool operator <=(Object other) => compareTo(other as JustTime) <= 0;
}
