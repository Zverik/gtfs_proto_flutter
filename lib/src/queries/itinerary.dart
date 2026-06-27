import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/feed.dart';
import 'package:gtfs_proto_flutter/src/models/itinerary.dart';
import 'package:sqflite/sqflite.dart';

class ItineraryQueries {
  final DatabaseHelper _database;

  const ItineraryQueries(this._database);

  Future<Itinerary?> getById(FeedId itineraryId) async => await queryById(await _database.database, itineraryId);

  static Future<Itinerary?> queryById(DatabaseExecutor db, FeedId itineraryId) async {
    final results = await db.rawQuery('select * from ${Itinerary.kTable.name} where feed_id = ? and itinerary_id = ?', [
      itineraryId.feedId,
      itineraryId.id,
    ]);
    return results.isEmpty ? null : Itinerary.fromJson(results.first);
  }

  Future<List<Itinerary>> getAllItineraries(String feedName) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Feed.kTable.name} left join ${Itinerary.kTable.name} using (feed_id) where feed_name = ?',
      [feedName],
    );
    return results.map((row) => Itinerary.fromJson(row)).toList();
  }

  Future<List<Itinerary>> getForStops(List<FeedId> stopIds) async {
    if (stopIds.isEmpty) return [];
    final db = await _database.database;
    final placeholders = List.generate(stopIds.length, (i) => '?').join(',');
    final results = await db.rawQuery(
      'select * from ${ItineraryStopRef.kTable.name} '
      'left join ${Itinerary.kTable.name} using (feed_id, itinerary_id) '
      'where feed_id = ? and stop_id in ($placeholders)',
      [stopIds.first.feedId, ...stopIds.map((s) => s.id)],
    );
    return results.map((row) => Itinerary.fromJson(row)).toList();
  }
}
