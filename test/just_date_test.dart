import 'package:flutter_test/flutter_test.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';

void main() {
  test('Compares correctly', () {
    final d1 = JustDate(2026, 4, 15);
    final d2 = JustDate(2026, 11, 30);
    final d0 = JustDate(2025, 12, 31);

    expect(d2 > d1, isTrue);
    expect(d2 >= d1, isTrue);
    expect(d1 < d2, isTrue);
    expect(d1 <= d2, isTrue);
    expect(d0 < d1, isTrue);
    expect(d2 > d0, isTrue);

    expect(d0 > d1, isFalse);
    expect(d2 < d0, isFalse);
  });

  test('Integer conversions', () {
    expect(JustDate(1970, 1, 1).toInt(), equals(0));
    expect(JustDate(1970, 2, 1).toInt(), equals(31));
    expect(JustDate(1971, 1, 1).toInt(), equals(365));

    final d1 = JustDate(2026, 4, 17);
    expect(d1.toInt(), greaterThan(365 * (2026 - 1970)));

    final d11 = JustDate.fromInt(d1.toInt());
    expect(d11.year, equals(d1.year));
    expect(d11.month, equals(d1.month));
    expect(d11.day, equals(d1.day));

    expect(JustDate.fromInt(d1.toInt() + 1).day, equals(18));
    expect(
      JustDate(1999, 12, 31).toInt() + 1,
      equals(JustDate(2000, 1, 1).toInt()),
    );
  });

  test('Weekdays are correct', () {
    expect(JustDate(1970, 1, 1).weekday, equals(3));
    expect(JustDate(2026, 6, 20).weekday, equals(5));
    expect(JustDate(2025, 12, 31).weekday, equals(2));
    expect(JustDate(2026, 4, 13).weekday, equals(0));
  });
}
