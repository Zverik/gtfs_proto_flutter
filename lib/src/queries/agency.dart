import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/agency.dart';
import 'package:sqflite/sqflite.dart';

class AgencyQueries {
  final DatabaseHelper _database;

  const AgencyQueries(this._database);

  Future<Agency?> getById(FeedId agencyId) async => await queryById(await _database.database, agencyId);

  static Future<Agency?> queryById(DatabaseExecutor db, FeedId agencyId) async {
    final results = await db.rawQuery('select * from ${Agency.kTable.name} where feed_id = ? and agency_id = ?', [
      agencyId.feedId,
      agencyId.id,
    ]);
    return results.isEmpty ? null : Agency.fromJson(results.first);
  }

  static Future<int?> querySingleId(DatabaseExecutor db, int feedId) async {
    final results = await db.rawQuery('select agency_id from ${Agency.kTable.name} where feed_id = ?', [feedId]);
    return results.length == 1 ? results.first['agency_id'] as int : null;
  }
}
