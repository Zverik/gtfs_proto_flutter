import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/helpers/schedule_item.dart';
import 'package:gtfs_proto_flutter/src/models.dart';
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

  Future<Trip?> getByGtfsId(String feedName, String gtfsId) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Trip.kTable.name} left join ${Feed.kTable.name} using (feed_id) '
      'where feed_name = ? and trip_gtfs_id = ?',
      [feedName, gtfsId],
    );
    return results.isEmpty ? null : Trip.fromJson(results.first);
  }

  Future<List<ScheduleItem>> findArrivalsForDay(FeedId routeId, FeedId stopId, JustDate date) async {
    final db = await _database.database;
    final result = await db.rawQuery(
      // TODO: order?
      'select i.* from ${ItineraryStopRef.kTable.name} isr '
      'left join ${Itinerary.kTable.name} i using (feed_id, itinerary_id) '
      'left join ${Route.kTable.name} r using (feed_id, route_id) '
      'left join ${DateServices.kTable.name} ds using (feed_id, service_id) '
      'left join ${Trip.kTable.name} t using (feed_id, itinerary_id, service_id) '
      'where isr.feed_id = ? and isr.stop_id = ? and r.route_id = ? and ds.date = ? ',
      [stopId.feedId, stopId.id, routeId.id, date.toInt()],
    );
    return []; // TODO
  }
}
