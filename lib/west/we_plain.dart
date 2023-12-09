import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:westminster_confession/bkmarks/bm_dialog.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/west/we_model.dart';
import 'package:westminster_confession/west/we_queries.dart';

// Plain Text pages

class WePlainArguments {
  final int index;
  WePlainArguments(this.index);
}

WEQueries weQueries = WEQueries();

class WePlainPage extends StatefulWidget {
  const WePlainPage({super.key});

  @override
  WePlainPageState createState() => WePlainPageState();
}

class WePlainPageState extends State<WePlainPage> {
  List<Wesminster> chapters = List<Wesminster>.empty();
  String chap = "Chapter";

  // @override
  // void initState() {
  //   super.initState();
  //   primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  // }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WePlainArguments;

    return FutureBuilder<List<Wesminster>>(
      future: weQueries.getChapters('plain'),
      builder: (context, AsyncSnapshot<List<Wesminster>> snapshot) {
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
                        detail: "1",
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
                      style: {
                        "html": html,
                        "h2": h2,
                        "h3": h3,
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

//showChapters(chapters, index, context) {
  // String chap = "Chapter";

  // PageController pageController =
  //     PageController(initialPage: chapters[index].id);

  // final html = Style(
  //     backgroundColor: Colors.white30,
  //     padding: HtmlPaddings.all(15),
  //     fontFamily: 'Raleway-Regular',
  //     fontSize: FontSize(primaryTextSize!));

  // final h2 = Style(fontSize: FontSize(primaryTextSize! + 2));
  // final h3 = Style(fontSize: FontSize(primaryTextSize!));

  // topAppBar(context) => AppBar(
  //       elevation: 0.1,
  //       backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
  //       leading: GestureDetector(
  //         child: IconButton(
  //           icon: const Icon(
  //             Icons.arrow_back_ios_new_sharp,
  //             color: Colors.white,
  //           ),
  //           onPressed: () {
  //             Future.delayed(
  //               Duration(milliseconds: Globals.navigatorDelay),
  //               () {
  //                 Navigator.pop(context);
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //       title: const Text(
  //         'Westminster Confession',
  //         style: TextStyle(
  //           color: Colors.yellow,
  //         ),
  //       ),
  //       centerTitle: true,
  //       actions: [
  //         IconButton(
  //           icon: const Icon(
  //             Icons.bookmark_outline_sharp,
  //             color: Colors.white,
  //           ),
  //           onPressed: () {
  //             int pg = pageController.page!.toInt();

  //             final model = BMModel(
  //                 title: "$chap ${pg + 1}",
  //                 subtitle: "${chapters[pg].title}",
  //                 detail: "1",
  //                 page: "$pg");

  //             BMDialog().bMWrapper(context, model);
  //           },
  //         ),
  //       ],
  //     );

  // return Scaffold(
  //   appBar: topAppBar(context),
  //   body: PageView.builder(
  //     itemCount: 33,
  //     controller: pageController,
  //     scrollDirection: Axis.horizontal,
  //     pageSnapping: true,
  //     itemBuilder: (BuildContext context, int index) {
  //       return SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //           child: Html(
  //             data: chapters[index].text,
  //             style: {
  //               "html": html,
  //               "h2": h2,
  //               "h3": h3,
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   ),
  // );
//}
