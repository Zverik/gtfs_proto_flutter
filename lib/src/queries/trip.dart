import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/trip.dart';
import 'package:sqflite/sqflite.dart';

class TripQueries {
  final DatabaseHelper _database;

  const TripQueries(this._database);

  Future<Trip?> getById(FeedId tripId) async => await queryById(await _database.database, tripId);

  static Future<Trip?> queryById(DatabaseExecutor db, FeedId tripId) async {
    final results = await db.rawQuery('select * from ${Trip.kTable.name} where feed_id = ? and trip_id = ?', [
      tripId.feedId,
      tripId.id,
    ]);
    return results.isEmpty ? null : Trip.fromJson(results.first);
  }
}
