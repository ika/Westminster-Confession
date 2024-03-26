// 5 points database queries

import 'package:westminster_confession/points/model.dart';
import 'package:westminster_confession/points/provider.dart';
import 'package:westminster_confession/utils/const.dart';

PointsProvider pointsProvider = PointsProvider();
const String _dbTable = Constants.pointsTable;

class PointsQueries {
  Future<List<Points>> getPoints() async {
    final db = await pointsProvider.database;

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

    return list;
  }
}
