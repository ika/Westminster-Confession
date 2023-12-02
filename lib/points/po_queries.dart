import 'package:westminster_confession/points/po_model.dart';
import 'package:westminster_confession/points/po_provider.dart';
import 'package:westminster_confession/utils/constants.dart';

POProvider poProvider = POProvider();
const String dbTable = Constants.PO_TBNAME;

class POQueries {
  Future<List<Points>> getChapters() async {
    final db = await poProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT id,text FROM $dbTable");

    List<Points> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Points(
                id: maps[i]['id'],
                text: maps[i]['text'],
              );
            },
          )
        : [];

    return list;
  }
}
