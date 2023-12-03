import 'package:westminster_confession/ecum/ecu_model.dart';
import 'package:westminster_confession/ecum/ecu_provider.dart';
import 'package:westminster_confession/utils/constants.dart';

CRProvider crProvider = CRProvider();
const String dbTable = Constants.CR_TBNAME;

class CRQueries {
  Future<List<Creeds>> getTitleList() async {
    final db = await crProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT id,chap,title FROM $dbTable");

    List<Creeds> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Creeds(
                  id: maps[i]['id'],
                  chap: maps[i]['chap'],
                  title: maps[i]['title']
                  //text: maps[i]['text']
                  );
            },
          )
        : [];

    return list;
  }

  Future<List<Creeds>> getChapters() async {
    final db = await crProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT id,title,text FROM $dbTable");

    List<Creeds> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Creeds(
                id: maps[i]['id'],
                title: maps[i]['title'],
                text: maps[i]['text'],
              );
            },
          )
        : [];

    return list;
  }
}
