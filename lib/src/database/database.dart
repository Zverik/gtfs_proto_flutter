import 'package:gtfs_proto_flutter/src/models/agency.dart';
import 'package:gtfs_proto_flutter/src/models/feed.dart';
import 'package:gtfs_proto_flutter/src/models/itinerary.dart';
import 'package:gtfs_proto_flutter/src/models/shape.dart';
import 'package:gtfs_proto_flutter/src/models/stop.dart';
import 'package:gtfs_proto_flutter/src/models/service.dart';
import 'package:gtfs_proto_flutter/src/models/route.dart';
import 'package:gtfs_proto_flutter/src/models/transfer.dart';
import 'package:gtfs_proto_flutter/src/models/trip.dart';
import 'package:sqflite/sqflite.dart';

/// Creates and manages the database. There should be just one instance of this
/// class.
class DatabaseHelper {
  final String _databaseName;

  DatabaseHelper({String databaseName = 'gtfs_proto.db'})
    : _databaseName = databaseName;

  Database? _db;

  Future<Database> get database async {
    _db ??= await createDatabase();
    return _db!;
  }

  Future<Database> createDatabase() async {
    return await openDatabase(
      _databaseName,
      version: 1,
      onCreate: initDatabase,
      onUpgrade: upgradeDatabase,
    );
  }

  static const kTables = [
    Feed.kTable,
    Agency.kTable,
    Service.kTable,
    DateServices.kTable,
    Shape.kTable,
    Stop.kTable,
    Route.kTable,
    Itinerary.kTable,
    ItineraryStopRef.kTable,
    Trip.kTable,
    Transfer.kTable,
  ];

  void initDatabase(Database database, int version) async {
    for (final table in kTables) {
      await database.execute(table.createSql());
      for (final sql in table.createIndices()) {
        await database.execute(sql);
      }
    }
  }

  void upgradeDatabase(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    if (newVersion >= 2 && oldVersion < 2) {
      // nothing yet
    }
  }
}
