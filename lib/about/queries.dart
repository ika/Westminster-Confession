// 5 points database queries

import 'package:westminster_confession/about/model.dart';
import 'package:westminster_confession/about/provider.dart';
import 'package:westminster_confession/utils/const.dart';

AboutProvider aboutProvider = AboutProvider();
const String _dbTable = Constants.aboutTable;

class AbQueries {

  Future<List<About>> getParagraphs() async {
    final db = await aboutProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<About> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return About(
                id: maps[i]['id'],
                h: maps[i]['h'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    return list;
  }
}
