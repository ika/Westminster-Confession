// 5 points database queries

import 'package:westminster_confession/pref/model.dart';
import 'package:westminster_confession/pref/provider.dart';
import 'package:westminster_confession/utils/const.dart';

PrefProvider prefProvider = PrefProvider();
const String _dbTable = Constants.prefaceTable;

class PRQueries {
  Future<List<Preface>> getParagraphs() async {
    final db = await prefProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<Preface> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Preface(
                id: maps[i]['id'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    return list;
  }
}
