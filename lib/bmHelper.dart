import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'bmModel.dart';
import 'constants.dart';

// Bookmarks database helper

class BMProvider {
  final String _dbName = Constants.BM_DBNAME;
  final String _dbTable = Constants.BM_TBNAME;

  static BMProvider _dbProvider;
  static Database _database;

  BMProvider._createInstance();

  factory BMProvider() {
    _dbProvider ??= BMProvider._createInstance();
    return _dbProvider;
  }

  Future<Database> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {},
      onCreate: (Database db, int version) async {
        // Create the note table
        await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    title TEXT DEFAULT '',
                    subtitle TEXT DEFAULT '',
                    detail TEXT DEFAULT '',
                    page TEXT DEFAULT ''
                )
            ''');
      },
    );
  }

  Future close() async {
    return _database.close();
  }

  Future<void> saveBookMark(BMModel model) async {
    final db = await database;
    await db.insert(
      _dbTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookMark(int id) async {
    final db = await database;
    await db.delete(_dbTable, where: "id = ?", whereArgs: [id]);
  }

  Future<List<BMModel>> getBookMarkList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT id, title, subtitle, detail, page FROM $_dbTable ORDER BY id DESC");

    return List.generate(
      maps.length,
      (i) {
        return BMModel(
          id: maps[i]['id'],
          title: maps[i]['title'],
          subtitle: maps[i]['subtitle'],
          detail: maps[i]['detail'],
          page: maps[i]['page'],
        );
      },
    );
  }
}
