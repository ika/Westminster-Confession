class BIModel {
  int id;
  int b; // book
  int c; // chapter
  int v; // verse
  String t; // text

  BIModel({this.id, this.b, this.c, this.v, this.t});

  // used when inserting data to the database
  // Map<String, dynamic> toMap() {
  //   return {'id': id, 'b': b, 'c': c, 'v': v, 't': t};
  // }
}