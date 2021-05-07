
// Main Database Moelel

class Chapter {
  int id;
  String chap;
  String title;
  String text;

  Chapter({this.id, this.chap, this.title, this.text});

  // used when inserting data to the database
  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     "id": id,
  //     "chap": chap,
  //     "title": title,
  //     "text": text,
  //   };
  // }
}
