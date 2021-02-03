import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _databaseVersion = 1;
  static const _databaseName = 'rinshoCollect.db';

  //tableName
  static const bookmarkTableName = 'favorite';

  static final DatabaseService dbProvider = DatabaseService();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    return await createDatabase();
  }

  Future createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    final database =
        await openDatabase(path, version: _databaseVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //not use this sample
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  Future initDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $bookmarkTableName (
        id TEXT PRIMARY KEY,
        isBookmark INTEGER NOT NULL
      )
    ''');
  }
}
