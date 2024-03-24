import 'package:westminster_confession/pref/pref_model.dart';
import 'package:westminster_confession/pref/pref_provider.dart';
import 'package:westminster_confession/utils/constants.dart';

// 5 points database queries

PRProvider prProvider = PRProvider();
const String dbTable = Constants.PR_TBNAME;

class PRQueries {
  Future<List<Preface>> getChapters() async {
    final db = await prProvider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $dbTable");

    List<Preface> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Preface(
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
