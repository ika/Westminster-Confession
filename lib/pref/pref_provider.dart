import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:westminster_confession/utils/constants.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/preface.html');
}

class PRProvider {
  final String _dbName = Constants.PR_DBNAME;
  final String _dbTable = Constants.PR_TBNAME;

  static PRProvider? _dbProvider;
  static Database? _database;

  PRProvider._createInstance();

  factory PRProvider() {
    _dbProvider ??= PRProvider._createInstance();
    return _dbProvider!;
  }

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future close() async {
    return _database!.close();
  }

  Future<Database> initDB() async {
    var contents = await loadAsset();

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) async {},
      onCreate: (Database db, int version) async {
        await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    text TEXT DEFAULT ''
                )
            ''');
        await db.execute(
            '''INSERT INTO $_dbTable ('text') VALUES (?)''', [contents]);
      },
    );
  }
}
