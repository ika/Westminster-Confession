// 5 points database queries

import 'package:westminster_confession/points/model.dart';
import 'package:westminster_confession/points/provider.dart';
import 'package:westminster_confession/utils/const.dart';

PointsProvider pointsProvider = PointsProvider();
const String _dbTable = Constants.pointsTable;

class PointsQueries {
  Future<List<Points>> getPoints() async {
    final db = await pointsProvider.database;

    // add empty lines at the end
    List<Points> addedLines = [];

    final line = Points(id: 0, h: '', t: '');

    for (int l = 0; l <= 15; l++) {
      addedLines.add(line);
    }

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<Points> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Points(
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
