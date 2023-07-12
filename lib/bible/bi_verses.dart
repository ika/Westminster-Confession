
import 'package:westminster_confession/bible/bi_model.dart';
import 'package:westminster_confession/bible/bi_queries.dart';

// Verses popup

BIQueries biQueries = BIQueries();

String ref = "";
String contents = "Error";
Map<String, String> data = {'header': ref, 'contents': contents};

Future<Map<String, String>> getVerseByReference(String m) async {

  var arr = m.split(';');
  ref = arr[0]; // Scripture reference

  if (arr[1] != 'extended') {

    var b = int.parse(arr[1]); // book
    var c = int.parse(arr[2]); // chapter
    var v = arr[3]; // verse

    String delimiter = '|';

    if (v.contains(delimiter)) {
      contents = "";
      var ver = v.split(delimiter);
      for (int i = 0; i < ver.length; i++) {
        int x = int.parse(ver[i]);
        List<BIModel> value = await biQueries.getBibleVerse(b, c, x);
          contents += "${value[0].t}  ";
      }
    } else {
      int x = int.parse(v);
      List<BIModel> value = await biQueries.getBibleVerse(b, c, x);
      contents = value[0].t;
    }
    data = {'header': ref, 'contents': contents};
  }
  return data;
}
