

import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/provider.dart';
import 'package:westminster_confession/utils/const.dart';

class WeQueries {

final String _tableName = Constants.proofsTable;

  Future<List<Wesminster>> getChapters() async {
    final db = await WeProvider().database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_tableName");

    List<Wesminster> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Wesminster(
                c: maps[i]['c'],
                v: maps[i]['v'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    return list;
  }


}
