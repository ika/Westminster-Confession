import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dbModel.dart';
import 'constants.dart';

// Main database helper

class DBProvider {
  final String _dbName = Constants.DB_DBNAME;
  //String _dbTable = Constants.DB_TBNAME;

  static DBProvider _dbProvider;
  static Database _database;

  DBProvider._createInstance();

  factory DBProvider() {
    _dbProvider ??= DBProvider._createInstance();
    return _dbProvider;
  }

  Future<Database> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  Future close() async {
    return _database.close();
  }

  Future<List<Chapter>> getTitleList(String _dbTable) async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT id, chap, title FROM $_dbTable");

    return List.generate(
      maps.length,
      (i) {
        return Chapter(
          id: maps[i]['id'],
          chap: maps[i]['chap'],
          title: maps[i]['title'],
          //text: maps[i]['text'],
        );
      },
    );
  }

  Future<List<Chapter>> getChapters(String _dbTable) async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT id, title, text FROM $_dbTable");

    return List.generate(
      maps.length,
      (i) {
        return Chapter(
          id: maps[i]['id'],
          //chap: maps[i]['chap'],
          title: maps[i]['title'],
          text: maps[i]['text'],
        );
      },
    );
  }
}
