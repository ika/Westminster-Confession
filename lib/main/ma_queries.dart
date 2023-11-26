import 'package:westminster_confession/main/ma_helper.dart';
import 'package:westminster_confession/main/ma_model.dart';

// Main database queries

DBProvider dbProvider = DBProvider();

class DBQueries {
  Future<List<Chapter>> getTitleList(String dbTable) async {
    final db = await dbProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $dbTable");

    List<Chapter> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Chapter(
                  id: maps[i]['id'],
                  chap: maps[i]['chap'],
                  title: maps[i]['title'],
                  text: maps[i]['text']);
            },
          )
        : [];

    return list;
  }

  Future<List<Chapter>> getChapters(String dbTable) async {
    final db = await dbProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $dbTable");

    List<Chapter> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Chapter(
                id: maps[i]['id'],
                chap: maps[i]['chap'],
                title: maps[i]['title'],
                text: maps[i]['text'],
              );
            },
          )
        : [];

    return list;
  }
}
