import 'package:sqflite/sqflite.dart';
import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/provider.dart';
import 'package:westminster_confession/utils/const.dart';
import 'package:westminster_confession/utils/utils.dart';

class WeQueries {
  final String _tableName = Constants.proofsTable;

  Future<List<Wesminster>> getChapter(int chap) async {
    final db = await WeProvider().database;

    // add empty lines at the end of the chapter
    List<Wesminster> addedLines = [];

    final line = Wesminster(id: 0, c: 0, v: 0, t: '');

    for (int l = 0; l <= 35; l++) {
      addedLines.add(line);
    }

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('''SELECT * FROM $_tableName WHERE c=?''', [chap]);

    List<Wesminster> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Wesminster(
                id: maps[i]['id'],
                c: maps[i]['c'],
                v: maps[i]['v'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    final heading = Wesminster(
      id: 0,
      c: 0,
      v: 0,
      t: "Chapter $chap:\n${westindex[chap - 1]}",
    );

    list.insert(0, heading); // add heading
    list.insertAll(list.length, addedLines); // add empty lines

    return list;
  }

    Future<int> getChapterCount() async {
    final db = await WeProvider().database;

    var cnt = Sqflite.firstIntValue(
      await db.rawQuery('''SELECT MAX(c) FROM $_tableName'''),
    );
    return cnt ?? 0;
  }
}
