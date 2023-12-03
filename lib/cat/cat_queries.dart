import 'package:westminster_confession/cat/cat_provider.dart';
import 'package:westminster_confession/cat/cat_model.dart';
import 'package:westminster_confession/utils/constants.dart';

CAProvider caProvider = CAProvider();
const String dbTable = Constants.CA_TBNAME;

class CAQueries {
  Future<List<Catachism>> getTitleList() async {
    final db = await caProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT id,chap,title FROM $dbTable");

    List<Catachism> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Catachism(
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

  Future<List<Catachism>> getChapters() async {
    final db = await caProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT id,chap,title,text FROM $dbTable");

    List<Catachism> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Catachism(
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
