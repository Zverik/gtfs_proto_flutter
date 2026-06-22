import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/feed.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';

class StopQueries {
  final DatabaseHelper _database;

  const StopQueries(this._database);

  Future<Stop?> getById(FeedId stopId) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Stop.kTable.name} where feed_id = ? and stop_id = ?',
      [stopId.feedId, stopId.id],
    );
    return results.isEmpty ? null : Stop.fromJson(results.first);
  }

  Future<Stop?> getByCode(String feedName, String stopCode) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Feed.kTable.name} left join ${Stop.kTable.name} using (feed_id) '
      'where feed_name = ? and code = ?',
      [feedName, stopCode],
    );
    return results.isEmpty ? null : Stop.fromJson(results.first);
  }

  Future<List<Stop>> findForHashes(List<String> geohashes) async {
    if (geohashes.isEmpty) return [];
    final db = await _database.database;
    final placeholders = List.generate(geohashes.length, (i) => '?').join(',');
    final results = await db.rawQuery(
      'select * from ${Stop.kTable.name} where geohash in ($placeholders)',
      geohashes,
    );
    return results.map((row) => Stop.fromJson(row)).toList();
  }
}
