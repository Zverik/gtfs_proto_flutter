import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/route.dart';
import 'package:sqflite/sqflite.dart';

class RouteQueries {
  final DatabaseHelper _database;

  const RouteQueries(this._database);

  Future<Route?> getById(FeedId routeId) async => await queryById(await _database.database, routeId);

  static Future<Route?> queryById(DatabaseExecutor db, FeedId routeId) async {
    final results = await db.rawQuery('select * from ${Route.kTable.name} where feed_id = ? and route_id = ?', [
      routeId.feedId,
      routeId.id,
    ]);
    return results.isEmpty ? null : Route.fromJson(results.first);
  }
}
