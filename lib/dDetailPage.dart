
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'verseReference.dart';
import 'alertDialog.dart';
import 'bmDialog.dart';
import 'bmHelper.dart';
import 'bmModel.dart';
import 'dbModel.dart';
import 'dbHelper.dart';

// The five points

DBProvider dbProvider = DBProvider();
BMProvider bmProvider = BMProvider();

int index = 0;

class DDetailPage extends StatefulWidget {
  DDetailPage(int index, {Key key}) : super(key: key) {
    index = index;
  }

  @override
  _DDetailPageState createState() => _DDetailPageState();
}

class _DDetailPageState extends State<DDetailPage> {
  List<Chapter> chapters = List<Chapter>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
      future: dbProvider.getChapters('dtexts'),
      builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data;
          return showChapters(chapters, index, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

showChapters(chapters, index, context) {
  String heading = "TULIP";

  PageController pageController =
      PageController(initialPage: chapters[index].id);

  final html = Style(
      backgroundColor: Colors.white30,
      padding: const EdgeInsets.all(15.0),
      fontFamily: 'Raleway-Regular',
      fontSize: const FontSize(16.0));

  final h2 = Style(fontSize: const FontSize(18.0));
  final h3 = Style(fontSize: const FontSize(16.0));
  final a =
      Style(fontSize: const FontSize(14.0), textDecoration: TextDecoration.none);

  final page0 = Html(
      data: chapters[0].text,
      style: {"html": html, "h2": h2, "h3": h3, "a": a},
      onLinkTap: (url, _, __, ___) async {
        Map<String, String> data = await getVerseByReference(url);
        showAlertDialog(context, data);
      });

  topAppBar(context) => AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(heading),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_outline_sharp,
              color: Colors.yellow,
            ),
            onPressed: () {
              var arr = List.filled(2, '');
              arr[0] = heading;
              arr[1] = 'The Five Points';

              BMDialog().showBmDialog(context, arr).then(
                (value) {
                  if (value == ConfirmAction.ACCEPT) {
                    final model = BMModel(
                      title: arr[0].toString(),
                      subtitle: note,
                      detail: "4",
                      page: "0",
                    );
                    bmProvider.saveBookMark(model);
                  }
                },
              );
            },
          ),
        ],
      );

  return Scaffold(
    appBar: topAppBar(context),
    body: PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      children: [
        SingleChildScrollView(
          child: page0,
        ),
      ],
    ),
  );
}
