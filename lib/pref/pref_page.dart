import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:westminster_confession/bkmarks/bm_dialog.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/pref/pref_model.dart';
import 'package:westminster_confession/pref/pref_queries.dart';
import 'package:westminster_confession/utils/globals.dart';

// Preface

class PrefPageArguments {
  final int index;
  PrefPageArguments(this.index);
}

PRQueries prQueries = PRQueries();

class PrefPage extends StatefulWidget {
  const PrefPage({super.key});

  @override
  PrefPageState createState() => PrefPageState();
}

class PrefPageState extends State<PrefPage> {
  List<Preface> chapters = List<Preface>.empty();
  String heading = "Preface";

  // @override
  // void initState() {
  //   super.initState();
  //   primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  // }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PrefPageArguments;

    return FutureBuilder<List<Preface>>(
      future: prQueries.getChapters(),
      builder: (context, AsyncSnapshot<List<Preface>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          PageController pageController =
              PageController(initialPage: chapters[args.index].id!);

          final html = Style(
              padding: HtmlPaddings.all(15),
              fontSize: FontSize(Globals.initialTextSize));

          final h2 = Style(fontSize: FontSize(Globals.initialTextSize + 2));
          final h3 = Style(fontSize: FontSize(Globals.initialTextSize));

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp
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
                heading, style: const TextStyle(fontWeight: FontWeight.w700)
                // style: const TextStyle(
                //   color: Colors.yellow,
                // ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_outline_sharp,
                  ),
                  onPressed: () {
                    int pg = pageController.page!.toInt();

                    final model = BMModel(
                        title: heading,
                        subtitle: "${chapters[pg].title}",
                        detail: "3",
                        page: "$pg");

                    BMDialog().bMWrapper(context, model);
                  },
                ),
              ],
            ),
            body: PageView.builder(
              itemCount: 1,
              controller: pageController,
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Html(
                      data: chapters[index].text,
                      style: {"html": html, "h2": h2, "h3": h3},
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
