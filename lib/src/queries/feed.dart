import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/models/feed.dart';

class FeedQueries {
  final DatabaseHelper _database;

  const FeedQueries(this._database);

  Future<Feed?> getByName(String feedName) async {
    final db = await _database.database;
    final result = await db.rawQuery(
      'select * from ${Feed.kTable.name} where feed_name = ?',
      [feedName],
    );
    return result.isEmpty ? null : Feed.fromJson(result.first);
  }
}
