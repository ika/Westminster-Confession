import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:westminster_confession/bkmarks/bm_dialog.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/bkmarks/bm_queries.dart';
import 'package:westminster_confession/main/ma_model.dart';
import 'package:westminster_confession/main/ma_queries.dart';
import 'package:westminster_confession/bible/bi_verses.dart';

// With Proofs pages

DBQueries dbQueries = DBQueries();

int index = 0;

class WeProofsPage extends StatefulWidget {
  WeProofsPage(int idx, {Key? key}) : super(key: key) {
    index = idx;
  }

  @override
  WeProofsPageState createState() => WeProofsPageState();
}

class WeProofsPageState extends State<WeProofsPage> {
  List<Chapter> chapters = List<Chapter>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
      future: dbQueries.getChapters('ftexts'),
      builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          return showChapters(chapters, index, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

showVerseDialog(BuildContext context, data) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(data['header']),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(data['contents']),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

showChapters(chapters, index, context) {
  String heading = "Westminster Confession";
  String chap = "Chapter";

  PageController pageController =
      PageController(initialPage: chapters[index].id);

  topAppBar(context) => AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(heading),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_outline_sharp,
              color: Colors.yellowAccent,
            ),
            onPressed: () {
              int pg = pageController.page!.toInt();
              int sp = pg + 1;

              var arr = List.filled(2, '');
              arr[0] = "$chap $sp";
              arr[1] = chapters[pg].title;

              BMDialog().showBmDialog(context, arr).then(
                (value) {
                  if (value) {
                    final model = BMModel(
                        title: arr[0].toString(),
                        subtitle: note,
                        detail: "5",
                        page: pg.toString());
                    BMQueries().saveBookMark(model);
                  }
                },
              );
            },
          ),
        ],
      );

  return Scaffold(
    appBar: topAppBar(context),
    body: PageView.builder(
      itemCount: 33,
      controller: pageController,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Html(
              data: chapters[index].text,
              extensions: const [
                TableHtmlExtension(),
              ],
              style: {
                "html": Style(
                  padding: HtmlPaddings.all(15.0),
                  fontFamily: 'Raleway-Regular',
                  fontSize: FontSize(16.0),
                ),
                "h2": Style(
                  fontSize: FontSize(18.0),
                ),
                "h3": Style(
                  fontSize: FontSize(16.0),
                ),
                "sup": Style(
                  verticalAlign: VerticalAlign.sup,
                  fontSize: FontSize(12.0),
                  color: Colors.red,
                ),
                "a": Style(
                  fontSize: FontSize(14.0),
                  textDecoration: TextDecoration.none,
                ),
                "table": Style(
                  border: Border.all(color: Colors.grey),
                  padding: HtmlPaddings.only(left: 5),
                  margin: Margins.only(bottom: 5),
                  backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  //width: Width(20, Unit.percent)
                ),
                "tr": Style(
                  //border: const Border(bottom: BorderSide(color: Colors.black54)),
                ),
                "th": Style(
                  color: Colors.red,
                  //padding: HtmlPaddings.all(4),
                  //alignment: Alignment.topLeft,
                  //width: Width(100, Unit.percent),
                  //backgroundColor: Colors.orangeAccent,
                ),
                "td": Style(
                  padding: HtmlPaddings.all(6),
                  alignment: Alignment.topLeft,
                ),
              },
              onLinkTap: (url, _, __) {
                if (url != null) {
                  getVerseByReference(url).then((value) {
                    showVerseDialog(context, value);
                  });
                }
              },
            ),
          ),
        );
      },
    ),
  );
}
