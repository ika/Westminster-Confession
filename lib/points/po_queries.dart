import 'package:westminster_confession/main/ma_model.dart';
import 'package:westminster_confession/points/po_helper.dart';
import 'package:westminster_confession/utils/constants.dart';

// 5 points database queries

POProvider poProvider = POProvider();
const String dbTable = Constants.PO_TBNAME;

class POQueries {

  Future<List<Chapter>> getChapters() async {
    final db = await poProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $dbTable");

    List<Chapter> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Chapter(
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
