import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'biModel.dart';
import 'constants.dart';

class BIProvider {
  final String _dbName = Constants.BI_DBNAME;
  final String _dbTable = 't_bible';

  static BIProvider _dbProvider;
  static Database _database;

  BIProvider._createInstance();

  factory BIProvider() {
    _dbProvider ??= BIProvider._createInstance();
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

  Future<List<BIModel>> getBibleVerse(int b, int c, int v) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT t FROM $_dbTable WHERE b=? AND c=? AND v=?",
        ['$b', '$c', '$v']);

    return List.generate(
      maps.length,
      (i) {
        return BIModel(
          // id: maps[i]['id'],
          // b: maps[i]['b'],
          // c: maps[i]['c'],
          // v: maps[i]['v'],
          t: maps[i]['t'],
        );
      },
    );
  }
}
