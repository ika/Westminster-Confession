import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:westminster_confession/bkmarks/bm_dialog.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/bible/bi_verses.dart';
import 'package:westminster_confession/points/po_model.dart';
import 'package:westminster_confession/points/po_queries.dart';
import 'package:westminster_confession/utils/globals.dart';

// The five points

class PointsArguments {
  final int index;
  PointsArguments(this.index);
}

POQueries poQueries = POQueries();

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  PointsPageState createState() => PointsPageState();
}

class PointsPageState extends State<PointsPage> {
  List<Points> chapters = List<Points>.empty();
  String heading = "TULIP";

  // @override
  // void initState() {
  //   super.initState();
  //   primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  // }

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
    final args = ModalRoute.of(context)!.settings.arguments as PointsArguments;

    return FutureBuilder<List<Points>>(
      future: poQueries.getChapters(), // see constants for table name
      builder: (context, AsyncSnapshot<List<Points>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          PageController pageController =
              PageController(initialPage: chapters[args.index].id!);

          final html = Style(
              backgroundColor: Colors.grey[200],
              padding: HtmlPaddings.all(15),
              fontSize: FontSize(Globals.initialTextSize));

          final h2 = Style(fontSize: FontSize(Globals.initialTextSize + 2));
          final h3 = Style(fontSize: FontSize(Globals.initialTextSize));
          final h4 = Style(fontSize: FontSize(Globals.initialTextSize));
          final a = Style(
              fontSize: FontSize(Globals.initialTextSize - 2),
              textDecoration: TextDecoration.none);

          final page0 = Html(
            data: chapters[0].text,
            style: {"html": html, "h2": h2, "h3": h3, "h4": h4, "a": a},
            onLinkTap: (url, _, __) {
              getVerseByReference(url!).then((value) {
                showVerseDialog(context, value);
              });
            },
          );
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
              title: Text(
                heading,
                // style: const TextStyle(
                //   color: Colors.yellow,
                // ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_outline_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final model = BMModel(
                        title: heading,
                        subtitle: "The Five Points",
                        detail: "4",
                        page: "0");

                    BMDialog().bMWrapper(context, model);
                  },
                ),
              ],
            ),
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
