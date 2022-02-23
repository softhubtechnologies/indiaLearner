import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final tableName = 'downloadsTable';

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await createDatabase();
      return _database;
    }
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'downloads.db');

    var database = await openDatabase(path, version: 1, onCreate: initDb, onUpgrade: onUpgrade);

    return database;
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  FutureOr<void> initDb(Database database, int version) async {
    await database.execute("CREATE TABLE $tableName ("
        //  "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "file TEXT "
        ")");
  }
}
