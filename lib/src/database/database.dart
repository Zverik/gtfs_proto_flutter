import 'package:gtfs_proto_flutter/src/models.dart' as m;
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
    m.Feed.kTable,
    m.Agency.kTable,
    m.Area.kTable,
    m.Service.kTable,
    m.DateServices.kTable,
    m.Network.kTable,
    m.Shape.kTable,
    m.Stop.kTable,
    m.Route.kTable,
    m.Itinerary.kTable,
    m.ItineraryStopRef.kTable,
    m.Trip.kTable,
    m.Transfer.kTable,
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
