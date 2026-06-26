import 'package:gtfs_proto_flutter/src/database/database.dart';
import 'package:gtfs_proto_flutter/src/database/feed_id.dart';
import 'package:gtfs_proto_flutter/src/models/shape.dart';
import 'package:sqflite/sqflite.dart';

class ShapeQueries {
  final DatabaseHelper _database;

  const ShapeQueries(this._database);

  Future<Shape?> getById(FeedId shapeId) async => await queryById(await _database.database, shapeId);

  static Future<Shape?> queryById(DatabaseExecutor db, FeedId shapeId) async {
    final results = await db.rawQuery('select * from ${Shape.kTable.name} where feed_id = ? and shape_id = ?', [
      shapeId.feedId,
      shapeId.id,
    ]);
    return results.isEmpty ? null : Shape.fromJson(results.first);
  }
}
