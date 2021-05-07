

// Utilities

// Color hexToColor(String code) {
//   return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
// }

  String reduceLength(String t, int l) {
    String note = (t.length > l) ? t.substring(0, l) + '...' : t;
    return note;
  }

  int getTime() {
    int time = DateTime.now().microsecondsSinceEpoch;
    return time;
  }

