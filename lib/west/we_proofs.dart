import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:westminster_confession/bkmarks/bm_dialog.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/bible/bi_verses.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/west/we_model.dart';
import 'package:westminster_confession/west/we_queries.dart';

// With Proofs pages

class WeProofArguments {
  final int index;
  WeProofArguments(this.index);
}

WEQueries weQueries = WEQueries();
double? primaryTextSize;

class WeProofsPage extends StatefulWidget {
  const WeProofsPage({super.key});

  @override
  WeProofsPageState createState() => WeProofsPageState();
}

class WeProofsPageState extends State<WeProofsPage> {
  List<Wesminster> chapters = List<Wesminster>.empty();
  String chap = "Chapter";

  @override
  void initState() {
    super.initState();
    primaryTextSize = Globals.initialTextSize;
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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WeProofArguments;

    return FutureBuilder<List<Wesminster>>(
      future: weQueries.getChapters('proofs'),
      builder: (context, AsyncSnapshot<List<Wesminster>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          PageController pageController =
              PageController(initialPage: chapters[args.index].id!);
          return Scaffold(
            appBar: AppBar(
              // elevation: 0.1,
              // backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              title: const Text(
                'Westminster Confession',
                // style: TextStyle(
                //   color: Colors.yellow,
                // ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_outline_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    int pg = pageController.page!.toInt();

                    final model = BMModel(
                        title: "$chap ${pg + 1}",
                        subtitle: "${chapters[pg].title}",
                        detail: "5",
                        page: "$pg");

                    BMDialog().bMWrapper(context, model);
                  },
                ),
              ],
            ),
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
                          padding: HtmlPaddings.all(15),
                          fontSize: FontSize(primaryTextSize!),
                        ),
                        "h2": Style(
                          fontSize: FontSize(primaryTextSize! + 2),
                        ),
                        "h3": Style(
                          fontSize: FontSize(primaryTextSize!),
                        ),
                        "sup": Style(
                          verticalAlign: VerticalAlign.sup,
                          fontSize: FontSize(primaryTextSize! - 4),
                          color: Colors.red,
                        ),
                        "a": Style(
                          fontSize: FontSize(14.0),
                          textDecoration: TextDecoration.none,
                        ),
                        "table": Style(
                          border: Border.all(color: Colors.blueGrey),
                          padding: HtmlPaddings.all(5),
                          margin: Margins.only(bottom: 10),
                          backgroundColor: Colors.blueGrey[50],
                          //const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                          //width: Width(20, Unit.percent)
                        ),
                        "tr": Style(
                          border: const Border(
                              bottom: BorderSide(color: Colors.black54)),
                        ),
                        "th": Style(
                          color: Colors.blueGrey,
                          padding: HtmlPaddings.all(4),
                          alignment: Alignment.topLeft,
                          width: Width(50, Unit.percent),
                          backgroundColor: Colors.blueGrey[100],
                        ),
                        "td": Style(
                          padding: HtmlPaddings.all(8),
                          alignment: Alignment.center,
                        ),
                      },
                      onLinkTap: (url, _, __) {
                        getVerseByReference(url!).then((value) {
                          showVerseDialog(context, value);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
