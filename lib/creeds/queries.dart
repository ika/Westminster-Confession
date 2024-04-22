// 5 points database queries

import 'package:westminster_confession/creeds/model.dart';
import 'package:westminster_confession/creeds/provider.dart';
import 'package:westminster_confession/utils/const.dart';

CreedsProvider creedsProvider = CreedsProvider();
const String _dbTable = Constants.creedsTable;

class CreedsQueries {
  Future<List<Creeds>> getCreeds() async {
    final db = await creedsProvider.database;

    // add empty lines at the end
    List<Creeds> addedLines = [];

    final line = Creeds(id: 0, h: '', t: '');

    for (int l = 0; l <= 15; l++) {
      addedLines.add(line);
    }

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<Creeds> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Creeds(
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
