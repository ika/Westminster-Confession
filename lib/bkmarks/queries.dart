import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:westminster_confession/bkmarks/provider.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/utils/const.dart';

// Bookmarks database helper

class BMQueries {
  final BMProvider provider = BMProvider();
  final String _dbTable = Constants.bmarksTable;

  Future<void> saveBookMark(BMModel model) async {
    final db = await provider.database;
    await db.insert(
      _dbTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookMark(int id) async {
    final db = await provider.database;
    await db.rawQuery('''DELETE FROM $_dbTable WHERE id=?''', [id]);
  }

  Future<List<BMModel>> getBookMarkList() async {
    final db = await provider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable ORDER BY id DESC");

    List<BMModel> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return BMModel(
                id: maps[i]['id'],
                title: maps[i]['title'],
                subtitle: maps[i]['subtitle'],
                page: maps[i]['page'],
                para: maps[i]['para'],
              );
            },
          )
        : [];
    return list;
  }

  Future<int> getBookMarkExists(int para) async {
    final db = await provider.database;

    var cnt = Sqflite.firstIntValue(
      await db
          .rawQuery('''SELECT MAX(id) FROM $_dbTable WHERE para=?''', [para]),
    );
    return cnt ?? 0;
  }
}
