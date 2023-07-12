import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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

  final html = Style(
      //backgroundColor: Colors.white30,
      padding: HtmlPaddings.all(15.0),
      //margin: HtmlPaddings.only(bottom: 20.0),
      fontFamily: 'Raleway-Regular',
      fontSize: FontSize(16.0));

  final h2 = Style(fontSize: FontSize(18.0));
  final h3 = Style(fontSize: FontSize(16.0));

  final a =
      Style(fontSize: FontSize(14.0), textDecoration: TextDecoration.none);

  final sup = Style(color: Colors.red);

  final table = Style(
    backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
    //width: double.infinity,
    padding: HtmlPaddings.only(top: 30.0),
  );

  final th = Style(
    padding: HtmlPaddings.all(6),
    backgroundColor: Colors.orangeAccent,
  );

  final tr = Style(
      //border: Border(bottom: BorderSide(color: Colors.grey)),
      );

  final td = Style(
    padding: HtmlPaddings.all(6.0),
  );

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
              arr[0] = "$heading $chap $sp";
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
              style: {
                "html": html,
                "h2": h2,
                "h3": h3,
                "a": a,
                "sup": sup,
                "table": table,
                "tr": tr,
                "th": th,
                "td": td
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
