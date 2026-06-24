import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
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
}
