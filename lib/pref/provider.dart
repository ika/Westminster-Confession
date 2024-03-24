import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:westminster_confession/utils/constants.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/preface.html');
}

class PRProvider {
  final int newDbVerson = 1;

  final String _dbName = Constants.PR_DBNAME;
  final String _dbTable = Constants.PR_TBNAME;

  PRProvider.internal();

  static dynamic _database;

  static final PRProvider _instance = PRProvider.internal();

  factory PRProvider() => _instance;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    Database db = await openDatabase(path);

    // not exists returns zero
    if (await db.getVersion() < newDbVerson) {
      db.close();
      await deleteDatabase(path);

      var contents = await loadAsset();

      db = await openDatabase(
        path,
        version: newDbVerson,
        onOpen: (db) async {},
        onCreate: (Database db, int version) async {
          await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    title TEXT DEFAULT '',
                    text TEXT DEFAULT ''
                )
            ''');
          await db.execute(
              '''INSERT INTO $_dbTable ('title', 'text') VALUES (?,?)''',
              ['Historical background', contents]);
        },
      );
    }
    return db;
  }

  Future close() async {
    return _database!.close();
  }
}
