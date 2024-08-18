import 'package:westminster_confession/proofs/model.dart';
import 'package:westminster_confession/proofs/provider.dart';
import 'package:westminster_confession/utils/const.dart';

class ReQueries {
  final String _tableName = Constants.proofsTable;

  Future<List<Refs>> getRef(int num) async {
    final db = await ReProvider().database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('''SELECT * FROM $_tableName WHERE n=?''', [num]);

    List<Refs> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Refs(
                id: maps[i]['rowid'],
                n: maps[i]['n'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    return list;
  }
}
