import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:westminster_confession/utils/constants.dart';

// Main database helper

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/dtexts.html');
}

class POProvider {
  final String _dbName = Constants.PO_DBNAME;
  final String _dbTable = Constants.PO_TBNAME;

  static POProvider? _dbProvider;
  static Database? _database;

  POProvider._createInstance();

  factory POProvider() {
    _dbProvider ??= POProvider._createInstance();
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
      version: 1,
      onOpen: (db) async {},
      onCreate: (Database db, int version) async {
        await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    chap TEXT DEFAULT '',
                    title TEXT DEFAULT '',
                    text TEXT DEFAULT ''
                )
            ''');
        await db.execute(
            '''INSERT INTO $_dbTable ('chap', 'title', 'text') VALUES (?, ?, ?)''',
            ['0', 'The Five Points of the Reformed Faith', contents]);
      },
    );
  }
}
