import 'package:westminster_confession/bible/bi_model.dart';
import 'package:westminster_confession/bible/bi_provider.dart';
import 'package:westminster_confession/utils/constants.dart';

BIProvider biProvider = BIProvider();

class BIQueries {
  final String _dbTable = Constants.BI_TBNAME;

  Future<List<BIModel>> getBibleVerse(int b, int c, int v) async {
    final db = await biProvider.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT t FROM $_dbTable WHERE b=? AND c=? AND v=?",
        ['$b', '$c', '$v']);

    List<BIModel> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return BIModel(
                // id: maps[i]['id'],
                // b: maps[i]['b'],
                // c: maps[i]['c'],
                // v: maps[i]['v'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    return list;
  }
}
