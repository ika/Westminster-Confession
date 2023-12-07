import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:westminster_confession/bkmarks/bm_dialog.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/cat/cat_model.dart';
import 'package:westminster_confession/cat/cat_queries.dart';
import 'package:westminster_confession/cubit/cub_size.dart';
import 'package:westminster_confession/utils/globals.dart';

// Larger Catechism pages

class CatPageArguments {
  final int index;
  CatPageArguments(this.index);
}

CAQueries caQueries = CAQueries();
double? primaryTextSize;

class CatPages extends StatefulWidget {
  const CatPages({super.key});

  @override
  CatPagesState createState() => CatPagesState();
}

class CatPagesState extends State<CatPages> {
  List<Catachism> chapters = List<Catachism>.empty();
  String heading = "Larger Catechism";

  @override
  void initState() {
    super.initState();
    primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CatPageArguments;

    return FutureBuilder<List<Catachism>>(
      future: caQueries.getChapters(),
      builder: (context, AsyncSnapshot<List<Catachism>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          PageController pageController =
              PageController(initialPage: chapters[args.index].id!);
          final html = Style(
              backgroundColor: Colors.white30,
              padding: HtmlPaddings.all(15),
              fontFamily: 'Raleway-Regular',
              fontSize: FontSize(primaryTextSize!));

          final h2 = Style(fontSize: FontSize(primaryTextSize! + 2));
          final h3 = Style(fontSize: FontSize(primaryTextSize!));
          return Scaffold(
            appBar: AppBar(
              // elevation: 0.1,
              // backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
              centerTitle: true,
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
                    int pg = pageController.page!.toInt();

                    final model = BMModel(
                        title: "$heading ${pg + 1}",
                        subtitle: "${chapters[pg].title}",
                        detail: "6",
                        page: "$pg");

                    BMDialog().bMWrapper(context, model);
                  },
                ),
              ],
            ),
            body: PageView.builder(
              itemCount: 196,
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
  // String heading = "Larger Catechism";

  // PageController pageController =
  //     PageController(initialPage: chapters[index].id);

  // final html = Style(
  //     backgroundColor: Colors.white30,
  //     padding: HtmlPaddings.all(15),
  //     fontFamily: 'Raleway-Regular',
  //     fontSize: FontSize(primaryTextSize!));

  // final h2 = Style(fontSize: FontSize(primaryTextSize! + 2));
  // final h3 = Style(fontSize: FontSize(primaryTextSize!));
  // final a =
  //     Style(fontSize: FontSize(14.0), textDecoration: TextDecoration.none);

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
  //       title: Text(
  //         heading,
  //         style: const TextStyle(
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
  //                 title: "$heading ${pg + 1}",
  //                 subtitle: "${chapters[pg].title}",
  //                 detail: "6",
  //                 page: "$pg");

  //             BMDialog().bMWrapper(context, model);
  //           },
  //         ),
  //       ],
  //     );


//}
