import 'package:gtfs_proto_flutter/src/database/feed_id.dart';

/// Meta information for creating a table and indices.
class TableMetadata {
  /// Table name.
  final String name;

  /// Integer primary key, e.g. "stop_id". Should be omitted from [columns].
  final String? key;

  /// List of columns and their types. E.g. "table_id integer primary key"
  /// or "name text".
  final List<String> columns;

  /// List of columns for indexing. Prepend with an exclamation mark for
  /// an unique index. E.g. "!short_name" or "type, name".
  final List<String> indexes;

  /// Marks a "many-to-many" reference table, not a part of the feed.
  final bool isManyToMany;

  const TableMetadata({
    required this.name,
    this.key,
    required this.columns,
    this.indexes = const [],
    this.isManyToMany = false,
  });

  /// Parses the two id fields, provided [key] is defined.
  FeedId readId(Map<String, dynamic> data) => FeedId.fromJson(data, key!);

  /// Fills the two JSON fields with ids, provided [key] is defined.
  Map<String, dynamic> writeId(FeedId id) => {'feed_id': id.feedId, key!: id.id};

  String createSql() {
    final myColumns = List.of(columns);
    if (key != null) {
      myColumns.insertAll(0, ['feed_id integer', '$key integer']);
    }
    return "create table $name (${myColumns.join(', ')})";
  }

  List<String> createIndices() {
    final result = <String>[];
    if (key != null) {
      result.add("create unique index ${name}_pk on $name (feed_id, $key)");
    }
    for (String column in indexes) {
      final unique = column.startsWith('!') ? 'unique' : '';
      if (unique.isNotEmpty) column = column.substring(1);
      final indexName = column.split(",").map((s) => s.trim().toLowerCase()).join('_');
      result.add("create $unique index ${name}_$indexName on $name ($column)");
    }
    return result;
  }
}
