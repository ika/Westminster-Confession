
// Bookmarks Model

class BMModel {
  int id;
  String title;
  String subtitle;
  String detail;
  String page;

  BMModel({this.id, this.title, this.subtitle, this.detail, this.page});

  // used when inserting data to the database
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'subtitle': subtitle, 'detail': detail, 'page': page};
  }
}
