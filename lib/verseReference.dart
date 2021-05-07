import 'biHelper.dart';
import 'biModel.dart';

// Verses popup

BIProvider biProvider = BIProvider();

Future<Map<String, String>> getVerseByReference(String m) async {
  var buffer = StringBuffer();
  buffer.clear();

  var arr = m.split(';');

  var ref = arr[0]; // Scripture reference

  if (arr[1] == 'extended') {
    // first word after the first semicolon
    String ex = "This text is too long to be shown here: See $ref";
    buffer.write(ex);
  } else {
    var b = int.parse(arr[1]); // book
    var c = int.parse(arr[2]); // chapter
    var v = arr[3]; // verse

    String delimiter = '|';

    if (v.contains(delimiter)) {
      var ver = v.split(delimiter);
      for (int i = 0; i < ver.length; i++) {
        int x = int.parse(ver[i]);
        List<BIModel> value = await biProvider.getBibleVerse(b, c, x);
        for (var val in value) {
          String l = val.t;
          String w = "$x. $l";
          buffer.writeln(w);
        }
      }
    } else {
      int x = int.parse(v);
      List<BIModel> value = await biProvider.getBibleVerse(b, c, x);
      for (var val in value) {
        String l = val.t;
        String w = "$x. $l";
        buffer.writeln(w);
      }
    }
  }

  Map<String, String> data = {'header': ref, 'contents': buffer.toString()};

  return data;
}
