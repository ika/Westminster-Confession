import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/bloc/bloc_font.dart';
import 'package:westminster_confession/bloc/bloc_italic.dart';
import 'package:westminster_confession/bloc/bloc_scroll.dart';
import 'package:westminster_confession/bloc/bloc_size.dart';
import 'package:westminster_confession/fonts/list.dart';
import 'package:westminster_confession/pref/model.dart';
import 'package:westminster_confession/pref/queries.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/menu.dart';
import 'package:westminster_confession/utils/utils.dart';

// Preface

// class PrefPageArguments {
//   final int index;
//   PrefPageArguments(this.index);
// }

PRQueries prQueries = PRQueries();

class PrefPage extends StatefulWidget {
  const PrefPage({super.key});

  @override
  PrefPageState createState() => PrefPageState();
}

class PrefPageState extends State<PrefPage> {
  ItemScrollController initialScrollController = ItemScrollController();
  List<Preface> paragraphs = List<Preface>.empty();
  String heading = "Preface";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
          if (initialScrollController.isAttached) {
            initialScrollController.scrollTo(
              index: context.read<ScrollBloc>().state,
              duration: Duration(milliseconds: Globals.navigatorLongDelay),
              curve: Curves.easeInOutCubic,
            );
            // reset scroll index
            context.read<ScrollBloc>().add(
                  UpdateScroll(index: 0),
                );
          } else {
            debugPrint("initialScrollController in NOT attached");
          }
        });
      },
    );
  }

    itemScrollControllerSelector() {
    initialScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as PrefPageArguments;

    return FutureBuilder<List<Preface>>(
      future: prQueries.getParagraphs(),
      builder: (context, AsyncSnapshot<List<Preface>> snapshot) {
        if (snapshot.hasData) {
          paragraphs = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
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
              title: Text(heading,
                  style: const TextStyle(fontWeight: FontWeight.w700)
                  // style: const TextStyle(
                  //   color: Colors.yellow,
                  // ),
                  ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: paragraphs.length,
                itemBuilder: (BuildContext context, int index) {
                  itemScrollControllerSelector();
                  return ListTile(
                    subtitle: Text(
                      paragraphs[index].t!,
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
                    onTap: () {
                      final model = BmModel(
                          title: 'Preface',
                          subtitle: prepareText(paragraphs[index].t!, 150),
                          doc: 2, // Prefrences
                          page: 0, // not used
                          para: index);

                      showPopupMenu(context, model);
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
