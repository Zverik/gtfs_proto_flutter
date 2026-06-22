import 'package:flutter_test/flutter_test.dart';
import 'package:gtfs_proto_flutter/src/database/database.dart';

void main() {
  test('Tables have differently-named columns', () {
    final refs = <String, List<String>>{};
    for (final table in DatabaseHelper.kTables) {
      if (table.isManyToMany) continue;
      for (final column in table.columns) {
        final name = column.split(" ").first;
        refs[name] = (refs[name] ?? []) + [table.name];
      }
    }
    refs.forEach((column, tables) {
      if (column != 'feed_id') {
        expect(tables.length, equals(1),
            reason: 'Tables having column "$column": ${tables.join(", ")}');
      }
    });
  });
}
