import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/helpers/just_date.dart';
import 'package:gtfs_proto_flutter/src/models/feed.dart';
import 'package:gtfs_proto_flutter/src/models/service.dart';
import 'package:sqflite/sqflite.dart';

class ServiceQueries {
  final DatabaseHelper _database;

  const ServiceQueries(this._database);

  Future<Service?> getById(FeedId serviceId) async => await queryById(await _database.database, serviceId);

  static Future<Service?> queryById(DatabaseExecutor db, FeedId serviceId) async {
    final results = await db.rawQuery('select * from ${Service.kTable.name} where feed_id = ? and service_id = ?', [
      serviceId.feedId,
      serviceId.id,
    ]);
    return results.isEmpty ? null : Service.fromJson(results.first);
  }

  Future<Service?> getByGtfsId(String feedName, String gtfsId) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Service.kTable.name} left join ${Feed.kTable.name} using (feed_id) where feed_name = ? and service_gtfs_id = ?',
      [feedName, gtfsId],
    );
    return results.isEmpty ? null : Service.fromJson(results.first);
  }

  /// Finds a list of serviceIds for a given date. It needs to be cached to query
  /// arrivals and trips. Returns results for all feeds.
  Future<List<FeedId>> queryByDate(JustDate date) async {
    final db = await _database.database;
    final results = await db.rawQuery(
      'select * from ${Service.kTable.name} where outer_start <= ? and outer_end >= ?',
      [date.toInt(), date.toInt()],
    );
    return results.map((row) => Service.fromJson(row)).where((s) => s.matches(date)).map((s) => s.id).toList();
  }

  Future<void> confirmTodayServices(JustDate date) async {
    final db = await _database.database;
    final results = await db.rawQuery('select feed_id from ${DateServices.kTable.name} where date = ? limit 1', [
      date.toInt(),
    ]);
    if (results.isNotEmpty) return;

    final serviceIds = await queryByDate(date);
    final batch = db.batch();
    for (final id in serviceIds) {
      batch.insert(DateServices.kTable.name, DateServices(date: date, serviceId: id).toJson());
    }
    await batch.commit();
  }
}
