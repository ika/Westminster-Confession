import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:westminster_confession/bkmarks/bm_provider.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/utils/constants.dart';

// Bookmarks database helper

class BMQueries {
  final String _dbTable = Constants.BM_TBNAME;
  final BMProvider provider = BMProvider();

  Future<void> saveBookMark(BMModel model) async {
    final db = await provider.db;
    await db.insert(
      _dbTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookMark(int id) async {
    final db = await provider.db;
    await db.delete(_dbTable, where: "id = ?", whereArgs: [id]);
  }

  Future<List<BMModel>> getBookMarkList() async {
    final db = await provider.db;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT id, title, subtitle, detail, page FROM $_dbTable ORDER BY id DESC");

    List<BMModel> list = maps.isNotEmpty
        ? List.generate(
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
          )
        : [];
    return list;
  }

  Future<int> getBookMarkExists(String detail, String page) async {
    final db = await provider.db;

    var cnt = Sqflite.firstIntValue(
      await db.rawQuery(
          '''SELECT MAX(id) FROM $_dbTable WHERE detail=? AND page=?''',
          [detail, page]),
    );
    return cnt ?? 0;
  }
}
