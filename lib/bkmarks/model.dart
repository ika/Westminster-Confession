// Bookmarks Model

class BMModel {
  int? id;
  String title;
  String subtitle;
  int page;
  int para; // paragraph id

  BMModel(
      {this.id,
      required this.title,
      required this.subtitle,
      required this.page,
      required this.para});

  // used when inserting data to the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'page': page,
      'para': para
    };
  }
}
