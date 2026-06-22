import 'package:flutter_test/flutter_test.dart';
import 'package:gtfs_proto_flutter/src/helpers/rolling_map.dart';

void main() {
  test('Rolling iterator rolls', () {
    final src = [1, 0, 1, 2, 0];
    expect(src.rollingMap(1, (p, c) => p + c), equals([2, 2, 3, 5, 5]));
  });
}