// 5 points database queries

import 'package:westminster_confession/pref/model.dart';
import 'package:westminster_confession/pref/provider.dart';
import 'package:westminster_confession/utils/const.dart';

PrefProvider prefProvider = PrefProvider();
const String _dbTable = Constants.prefaceTable;

class PRQueries {
  Future<List<Preface>> getParagraphs() async {
    final db = await prefProvider.database;

    // add empty lines at the end
    List<Preface> addedLines = [];

    final line = Preface(id: 0, t: '');

    for (int l = 0; l <= 15; l++) {
      addedLines.add(line);
    }

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

    list.insertAll(list.length, addedLines); // add empty lines

    return list;
  }
}
