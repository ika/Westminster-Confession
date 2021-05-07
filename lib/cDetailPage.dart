import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'bmDialog.dart';
import 'bmHelper.dart';
import 'bmModel.dart';
import 'dbModel.dart';
import 'dbHelper.dart';

// Preface

DBProvider dbProvider = DBProvider();
BMProvider bmProvider = BMProvider();

int index = 0;

class CDetailPage extends StatefulWidget {
  CDetailPage(int index) {
    index = index;
  }

  @override
  _CDetailPageState createState() => _CDetailPageState();
}

class _CDetailPageState extends State<CDetailPage> {
  List<Chapter> chapters = List<Chapter>.empty();

  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
        future: dbProvider.getChapters('ctexts'),
        builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
          if (snapshot.hasData) {
            chapters = snapshot.data;
            return showChapters(chapters, index, context);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

showChapters(chapters, index, context) {
  String heading = "Preface";

  PageController pageController =
      PageController(initialPage: chapters[index].id);

  final html = Style(
      backgroundColor: Colors.white30,
      padding: EdgeInsets.all(15.0),
      fontFamily: 'Raleway-Regular',
      fontSize: FontSize(16.0));

  final h2 = Style(fontSize: FontSize(18.0));
  final h3 = Style(fontSize: FontSize(16.0));

  topAppBar(context) => AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(heading),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.bookmark_outline_sharp,
                color: Colors.yellow,
              ),
              onPressed: () {
                int pg = pageController.page.toInt();

                var arr = new List.filled(2,'');
                arr[0] = heading;
                arr[1] = chapters[pg].title;

                BMDialog().showBmDialog(context, arr).then((value) {
                  if (value == ConfirmAction.ACCEPT) {
                    final model = BMModel(
                      title: arr[0].toString(),
                      subtitle: note,
                      detail: "3",
                      page: pg.toString(),
                    );
                    bmProvider.saveBookMark(model);
                  }
                });
              }),
        ],
      );

        return Scaffold(
      appBar: topAppBar(context),
      body: PageView.builder(
          itemCount: 1,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                child: Html(
                  data: chapters[index].text,
                  style: {"html": html, "h2": h2, "h3": h3},
                ),
              ),
            ));
          }));

}
