import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:westminster_confession/bkmarks/bm_dialog.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/cubit/cub_size.dart';
import 'package:westminster_confession/ecum/ecu_model.dart';
import 'package:westminster_confession/ecum/ecu_queries.dart';
import 'package:westminster_confession/utils/globals.dart';

// Ecumenical Creeds

class ECUPageArguments {
  final int index;
  ECUPageArguments(this.index);
}

CRQueries crQueries = CRQueries();
double? primaryTextSize;

class ECUPage extends StatefulWidget {
  const ECUPage({super.key});

  @override
  ECUPageState createState() => ECUPageState();
}

class ECUPageState extends State<ECUPage> {
  List<Creeds> chapters = List<Creeds>.empty();
  String heading = "Ecumenical Creeds";

  @override
  void initState() {
    super.initState();
    primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ECUPageArguments;

    return FutureBuilder<List<Creeds>>(
      future: crQueries.getChapters(),
      builder: (context, AsyncSnapshot<List<Creeds>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          PageController pageController =
              PageController(initialPage: chapters[args.index].id!);

          final html = Style(
              padding: HtmlPaddings.all(15),
              fontSize: FontSize(primaryTextSize!));

          final h2 = Style(fontSize: FontSize(primaryTextSize! + 2));
          final h3 = Style(fontSize: FontSize(primaryTextSize!));
          final i = Style(
              fontSize: FontSize(primaryTextSize!),
              fontStyle: FontStyle.italic);
          return Scaffold(
            appBar: AppBar(
              // elevation: 0.1,
              // backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
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
                'Ecumenical Creeds',
                // style: TextStyle(
                //   color: Colors.yellow,
                // ),
              ),
              // centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.bookmark_outline_sharp),
                  onPressed: () {
                    int pg = pageController.page!.toInt();

                    final model = BMModel(
                        title: heading,
                        subtitle: "${chapters[pg].title}",
                        detail: "2",
                        page: "$pg");

                    BMDialog().bMWrapper(context, model);
                  },
                ),
              ],
            ),
            body: PageView.builder(
              itemCount: 3,
              controller: pageController,
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Html(
                      data: chapters[index].text,
                      style: {"html": html, "h2": h2, "h3": h3, "i": i},
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
