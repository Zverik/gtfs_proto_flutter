import 'package:gtfs_proto_flutter/src/database/table_metadata.dart';

class Feed {
  final int id;
  final String name;
  final int version;
  final DateTime updated;

  Feed({
    required this.id,
    required this.name,
    required this.version,
    DateTime? updated,
  }) : updated = updated ?? DateTime.now();

  Feed withId(int newId) =>
      Feed(id: newId, name: name, version: version, updated: updated);

  static const kTable = TableMetadata(
    name: 'feed',
    columns: [
      'feed_id integer primary key',
      'feed_name text unique',
      'version integer',
      'updated integer',
    ],
    indexes: ['feed_name'],
  );

  factory Feed.fromJson(Map<String, dynamic> data) => Feed(
    id: data['feed_id'],
    name: data['feed_name'],
    version: data['version'],
    updated: DateTime.fromMillisecondsSinceEpoch(data['updated']),
  );

  Map<String, dynamic> toJson() => {
    if (id >= 0) 'id': id, // hack for creating new feeds
    'feed_name': name,
    'version': version,
    'updated': updated.millisecondsSinceEpoch,
  };

  @override
  bool operator ==(Object other) =>
      other is Feed && other.id == id && other.name == name;

  @override
  int get hashCode => Object.hash(id, name);
}
