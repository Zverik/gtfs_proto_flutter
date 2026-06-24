import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
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
}
