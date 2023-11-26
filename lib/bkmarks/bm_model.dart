// Bookmarks Model

class BMModel {
  int? id;
  String title;
  String subtitle;
  String detail;
  String page;

  BMModel(
      {this.id,
      required this.title,
      required this.subtitle,
      required this.detail,
      required this.page});

  // used when inserting data to the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'detail': detail,
      'page': page
    };
  }
}
