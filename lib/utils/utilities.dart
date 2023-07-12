// Utilities

String reduceLength(String t, int l) {
  String note = (t.length > l) ? '${t.substring(0, l)}...' : t;
  return note;
}

int getTime() {
  int time = DateTime.now().microsecondsSinceEpoch;
  return time;
}
