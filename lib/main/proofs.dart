import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/bloc/bloc_refs.dart';
import 'package:westminster_confession/bloc/bloc_scroll.dart';
import 'package:westminster_confession/main/menu.dart';
import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/queries.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:westminster_confession/refs/getref.dart';
import 'package:westminster_confession/refs/queries.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/utils.dart';

late bool refsAreOn;
bool? initialPageScroll;
ItemScrollController? initialScrollController;

class ProofsPage extends StatefulWidget {
  const ProofsPage({super.key, required this.page});

  final int page;

  @override
  State<ProofsPage> createState() => _ProofsPageState();
}

class _ProofsPageState extends State<ProofsPage> {
  @override
  void initState() {
    super.initState();
    refsAreOn = context.read<RefsBloc>().state;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        initialScrollController = ItemScrollController();

        Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
          if (initialScrollController!.isAttached) {
            initialScrollController!.scrollTo(
              index: context.read<ScrollBloc>().state,
              duration: Duration(milliseconds: Globals.navigatorLongDelay),
              curve: Curves.easeInOutCubic,
            );
          }
        });
      },
    );
  }

  showListTile(Wesminster chapter) {
    return (refsAreOn)
        ? ListTile(
            title: LinkifyText(
              "${chapter.t}",
              linkStyle: const TextStyle(color: Colors.red),
              linkTypes: const [LinkType.hashTag],
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
            //title: Text("${chapter.t}".replaceAll(RegExp(r"#\d+"), "")),
            title: Text(replaceNumbers(chapter.t!)),
          );
  }

  String replaceNumbers(String txt) {
    return txt.replaceAll(RegExp(r"#\d+"), "");
  }

  // text and length
  String prepareText(String txt, int len) {
    txt = replaceNumbers(txt);
    if (txt.length > len) {
      txt = txt.substring(0, len);
    }
    return txt;
  }

  ItemScrollController? itemScrollControllerSelector() {
    if (initialPageScroll!) {
      initialPageScroll = false;
      return initialScrollController; // initial scroll
    } else {
      return ItemScrollController(); // PageView scroll
    }
  }

  @override
  Widget build(BuildContext context) {
    initialPageScroll = true;
    final PageController pageController =
        PageController(initialPage: widget.page - 1);
    //final ItemScrollController itemScrollController = ItemScrollController();
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
        body: PageView.builder(
          controller: pageController,
          itemCount: 33,
          physics: const BouncingScrollPhysics(),
          pageSnapping: true,
          itemBuilder: (BuildContext context, int index) {
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
                      itemScrollController: itemScrollControllerSelector(),
                      itemBuilder: (BuildContext context, int index) {
                        final chapter = snapshot.data![index];
                        return GestureDetector(
                          child: showListTile(chapter),
                          onTap: () {
                            final model = BMModel(
                                title: westindex[chapter.c! - 1],
                                subtitle: prepareText(chapter.t!, 150),
                                page: chapter.c!,
                                para: chapter.id!);

                            showPopupMenu(context, model);
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
    );
  }
}
