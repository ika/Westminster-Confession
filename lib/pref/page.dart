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
  //late bool themeIsDark;

  @override
  void initState() {
    super.initState();
    //themeIsDark = context.read<ThemeBloc>().state;
    var scrollBlocState = context.read<ScrollBloc>().state;
    // reset scroll index
    context.read<ScrollBloc>().add(UpdateScroll(index: 0));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
        if (initialScrollController.isAttached) {
          initialScrollController.scrollTo(
            index: scrollBlocState,
            duration: Duration(milliseconds: Globals.navigatorLongDelay),
            curve: Curves.easeInOutCubic,
          );
        } else {
          debugPrint("initialScrollController in NOT attached");
        }
      });
    });
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.surface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              leading: GestureDetector(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ),
              title: Text(
                'Preface',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollablePositionedList.builder(
                itemCount: paragraphs.length,
                itemScrollController: initialScrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    subtitle: Text(
                      paragraphs[index].t,
                      style: TextStyle(
                        fontFamily: fontsList[context.read<FontBloc>().state],
                        fontStyle: (context.read<ItalicBloc>().state)
                            ? FontStyle.italic
                            : FontStyle.normal,
                        fontSize: context.read<SizeBloc>().state,
                      ),
                    ),
                    onTap: () {
                      final model = BmModel(
                        title: 'Preface',
                        subtitle: paragraphs[index].t,
                        doc: 2,
                        // Prefrences
                        page: 0,
                        // not used
                        para: index,
                      );

                      //debugPrint(model.para.toString());

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
