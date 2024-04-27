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

int indexNumber = 0;
int pageNumber = 0;

WeQueries weQueries = WeQueries();
late PageController? pageController;

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
            initialScrollController
                .scrollTo(
              index: indexNumber, //context.read<ScrollBloc>().state,
              duration: Duration(milliseconds: Globals.navigatorLongDelay),
              curve: Curves.easeInOutCubic,
            )
                .then((value) {
              // reset scrollto
              context.read<ScrollBloc>().add(
                    UpdateScroll(index: 0),
                  );
            });
          } else {
            debugPrint("initialScrollController is NOT attached");
          }
        });
      },
    );
  }

  itemScrollControllerSelector() {
    initialScrollController = ItemScrollController();
  }

  void getPageController() {
    pageController = PageController(initialPage: pageNumber);
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

  @override
  Widget build(BuildContext context) {
    //debugPrint("SCROLL TO INDEX ${context.read<ScrollBloc>().state}");
    indexNumber = context.read<ScrollBloc>().state;
    pageNumber = widget.page;
    getPageController();
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
        body: FutureBuilder<int>(
          future: weQueries.getChapterCount(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              int chapterCount = snapshot.data!.toInt();
              return ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse
                  },
                ),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: chapterCount,
                  physics: const BouncingScrollPhysics(),
                  pageSnapping: true,
                  itemBuilder: (BuildContext context, int index) {
                    itemScrollControllerSelector();
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<List<Wesminster>>(
                        future: weQueries.getChapter(
                            index + 1), // index +1 from page controller
                        initialData: const [],
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Wesminster>> snapshot) {
                          if (snapshot.hasData) {
                            return ScrollablePositionedList.builder(
                              itemCount: snapshot.data!.length,
                              itemScrollController: initialScrollController,
                              itemBuilder: (BuildContext context, int index) {
                                final chapter = snapshot.data![index];
                                return GestureDetector(
                                  child: showListTile(chapter),
                                  onTap: () {
                                    final model = BmModel(
                                        title: westindex[chapter.c! - 1],
                                        subtitle: chapter.t!,
                                        doc: 1, // document one
                                        page: chapter.c!,
                                        para: index);

                                    showPopupMenu(context, model);
                                  },
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    // move to next chapter
                    pageNumber = index + 1;
                    // context
                    //     .read<ChapterBloc>()
                    //     .add(UpdateChapter(chapter: index + 1));
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
