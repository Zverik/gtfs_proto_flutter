import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/feed.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';
import 'package:sqflite/sqflite.dart';

class StopQueries {
  final DatabaseHelper _database;

  const StopQueries(this._database);

  Future<Stop?> getById(FeedId stopId) async => await queryById(await _database.database, stopId);

  static Future<Stop?> queryById(DatabaseExecutor db, FeedId stopId) async {
    final results = await db.rawQuery('select * from ${Stop.kTable.name} where feed_id = ? and stop_id = ?', [
      stopId.feedId,
      stopId.id,
    ]);
    return results.isEmpty ? null : Stop.fromJson(results.first);
  }

  Future<Map<FeedId, Stop>> getByIds(Iterable<FeedId> stopIds) async {
    final db = await _database.database;
    final feedIds = stopIds.map((s) => s.feedId).toSet();
    final feedPlaces = List.generate(feedIds.length, (i) => '?').join(',');
    final stopPlaces = List.generate(stopIds.length, (i) => '?').join(',');
    final results = await db.rawQuery(
      'select * from ${Stop.kTable.name} where feed_id in ($feedPlaces) and stop_id in ($stopPlaces)',
      [...feedIds, ...stopIds.map((s) => s.id)],
    );
    return {
      for (final stop in results.map((row) => Stop.fromJson(row)))
        if (stopIds.contains(stop.id)) stop.id: stop,
    };
  }

  Future<Stop?> getByCode(String feedName, String stopCode) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Feed.kTable.name} left join ${Stop.kTable.name} using (feed_id) '
      'where feed_name = ? and stop_code = ?',
      [feedName, stopCode],
    );
    return results.isEmpty ? null : Stop.fromJson(results.first);
  }

  Future<Stop?> getByGtfsId(String feedName, String gtfsId) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Stop.kTable.name} left join ${Feed.kTable.name} using (feed_id) where feed_name = ? and stop_gtfs_id = ?',
      [feedName, gtfsId],
    );
    return results.isEmpty ? null : Stop.fromJson(results.first);
  }

  Future<List<Stop>> getAllStops(String feedName) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Feed.kTable.name} left join ${Stop.kTable.name} using (feed_id) where feed_name = ?',
      [feedName],
    );
    return results.map((row) => Stop.fromJson(row)).toList();
  }

  Future<List<Stop>> findForHashes(List<String> geohashes) async {
    if (geohashes.isEmpty) return [];
    final db = await _database.database;
    final placeholders = List.generate(geohashes.length, (i) => '?').join(',');
    final results = await db.rawQuery('select * from ${Stop.kTable.name} where geohash in ($placeholders)', geohashes);
    return results.map((row) => Stop.fromJson(row)).toList();
  }
}
