import 'package:westminster_confession/west/we_model.dart';
import 'package:westminster_confession/west/we_provider.dart';

WEProvider weProvider = WEProvider();

class WEQueries {
  Future<List<Wesminster>> getTitleList(String dbTable) async {
    final db = await weProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $dbTable");

    List<Wesminster> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Wesminster(
                  id: maps[i]['id'],
                  chap: maps[i]['chap'],
                  title: maps[i]['title'],
                  text: maps[i]['text']);
            },
          )
        : [];

    return list;
  }

  Future<List<Wesminster>> getChapters(String dbTable) async {
    final db = await weProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $dbTable");

    List<Wesminster> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Wesminster(
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
