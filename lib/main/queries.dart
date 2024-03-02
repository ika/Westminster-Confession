import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/provider.dart';
import 'package:westminster_confession/utils/const.dart';
import 'package:westminster_confession/utils/utils.dart';

class WeQueries {
  final String _tableName = Constants.proofsTable;

  Future<List<Wesminster>> getChapter(int chap) async {
    final db = await WeProvider().database;

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

    final model = Wesminster(
      id: 0,
      c: 0,
      v: 0,
      t: "Chapter $chap:\n${westindex[chap -1]}",
    );

    list.insert(0, model);

    return list;
  }
}
