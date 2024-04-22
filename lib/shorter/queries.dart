// 5 points database queries

import 'package:westminster_confession/shorter/model.dart';
import 'package:westminster_confession/shorter/provider.dart';
import 'package:westminster_confession/utils/const.dart';

ShorterProvider shorterProvider = ShorterProvider();
const String _dbTable = Constants.shorterTable;

class ShorterQueries {
  Future<List<Shorter>> getShorter() async {
    final db = await shorterProvider.database;

    // add empty lines at the end
    List<Shorter> addedLines = [];

    final line = Shorter(id: 0, h: '', t: '');

    for (int l = 0; l <= 15; l++) {
      addedLines.add(line);
    }

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<Shorter> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Shorter(
                id: maps[i]['id'],
                h: maps[i]['h'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    list.insertAll(list.length, addedLines); // add empty lines

    return list;
  }
}
