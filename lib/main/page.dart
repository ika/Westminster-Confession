import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/bloc/bloc_font.dart';
import 'package:westminster_confession/bloc/bloc_italic.dart';
import 'package:westminster_confession/bloc/bloc_refs.dart';
import 'package:westminster_confession/bloc/bloc_scroll.dart';
import 'package:westminster_confession/bloc/bloc_size.dart';
import 'package:westminster_confession/fonts/list.dart';
import 'package:westminster_confession/utils/menu.dart';
import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/queries.dart';
import 'package:westminster_confession/refs/getref.dart';
import 'package:westminster_confession/refs/queries.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/utils.dart';

late bool refsAreOn;

class ProofsPage extends StatefulWidget {
  const ProofsPage({super.key, required this.page});

  final int page;

  @override
  State<ProofsPage> createState() => _ProofsPageState();
}

class _ProofsPageState extends State<ProofsPage> {
  ItemScrollController initialScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    refsAreOn = context.read<RefsBloc>().state;

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

  Widget showListTile(Wesminster chapter) {
    return (refsAreOn)
        ? ListTile(
            title: LinkifyText(
              "${chapter.t}",
              linkStyle: const TextStyle(color: Colors.red),
              linkTypes: const [LinkType.hashTag],
              textStyle: TextStyle(
                  fontFamily: fontsList[context.read<FontBloc>().state],
                  fontStyle: (context.read<ItalicBloc>().state)
                      ? FontStyle.italic
                      : FontStyle.normal,
                  fontSize: context.read<SizeBloc>().state),
              onTap: (link) {
                int lnk = int.parse(link.value!.toString().replaceAll('#', ''));

                ReQueries().getRef(lnk).then(
                  (value) {
                    String n = value.elementAt(0).n.toString();
                    String t = value.elementAt(0).t.toString();

                    // remove number from the text
                    int p = t.indexOf(' ');
                    t = t.substring(p).trim();

                    Map<String, String> data = {'header': n, 'contents': t};

                    GetRef().refDialog(context, data);
                  },
                );
              },
            ),
          )
        : ListTile(
            title: Text(
              replaceNumbers(chapter.t!),
              style: TextStyle(
                  fontFamily: fontsList[context.read<FontBloc>().state],
                  fontStyle: (context.read<ItalicBloc>().state)
                      ? FontStyle.italic
                      : FontStyle.normal,
                  fontSize: context.read<SizeBloc>().state),
            ),
          );
  }

  itemScrollControllerSelector() {
    initialScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        PageController(initialPage: widget.page - 1);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          actions: [
            Switch(
              value: refsAreOn,
              onChanged: (bool value) {
                context.read<RefsBloc>().add(ChangeRefs(value));
                setState(() {
                  refsAreOn = value;
                });
              },
            ),
          ],
          title: const Text(
            'Westminster',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              Future.delayed(Duration(microseconds: Globals.navigatorDelay),
                  () {
                Navigator.of(context).pop();
              });
            },
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: PageView.builder(
            controller: pageController,
            itemCount: 33,
            physics: const BouncingScrollPhysics(),
            pageSnapping: true,
            itemBuilder: (BuildContext context, int index) {
              itemScrollControllerSelector();
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<Wesminster>>(
                  future: WeQueries().getChapter(index + 1),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // return ListView.builder(
                      //   itemCount: snapshot.data!.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     final chapter = snapshot.data![index];
                      //     return GestureDetector(
                      //         child: showListTile(chapter),
                      //         onTap: () {
                      //           final model = BMModel(
                      //               title: westindex[index + 1],
                      //               subtitle: prepareText(chapter.t!, 150),
                      //               page: chapter.c!,
                      //               para: chapter.id!);

                      //           showPopupMenu(context, model);
                      //         });
                      //   },
                      // );
                      return ScrollablePositionedList.builder(
                        itemCount: snapshot.data!.length,
                        itemScrollController: initialScrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final chapter = snapshot.data![index];
                          return GestureDetector(
                            child: showListTile(chapter),
                            onTap: () {
                              if (chapter.id! > 0) {
                                final model = BmModel(
                                    title: westindex[chapter.c! - 1],
                                    subtitle: chapter.t!,
                                    doc: 1, // document one
                                    page: chapter.c!,
                                    para: index);

                                showPopupMenu(context, model);
                              }

                              //debugPrint(chapter.id.toString());
                            },
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
