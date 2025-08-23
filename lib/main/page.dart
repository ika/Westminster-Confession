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
import 'package:westminster_confession/bloc/bloc_theme.dart';
import 'package:westminster_confession/fonts/list.dart';
import 'package:westminster_confession/utils/menu.dart';
import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/queries.dart';
import 'package:westminster_confession/proofs/getref.dart';
import 'package:westminster_confession/proofs/queries.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/utils.dart';

WeQueries weQueries = WeQueries();

class ProofsPage extends StatefulWidget {
  const ProofsPage({super.key, required this.page});
  final int page;

  @override
  State<ProofsPage> createState() => _ProofsPageState();
}

class _ProofsPageState extends State<ProofsPage> {
  late final PageController pageController;
  late bool refsAreOn;
  late bool themeIsDark;
  //int indexNumber = 0;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    refsAreOn = context.read<RefsBloc>().state;
    themeIsDark = context.read<ThemeBloc>().state;
    // controll scrollTo indexNumber here
    //indexNumber = context.read<ScrollBloc>().state;
    pageNumber = widget.page;
    pageController = PageController(initialPage: pageNumber);
  }

  Widget showListTile(Wesminster chapter) {
    final fontBloc = context.read<FontBloc>().state;
    final italicBloc = context.read<ItalicBloc>().state;
    final sizeBloc = context.read<SizeBloc>().state;

    if (refsAreOn) {
      return ListTile(
        title: LinkifyText(
          "${chapter.t}",
          linkStyle: const TextStyle(color: Colors.red),
          linkTypes: const [LinkType.hashTag],
          textStyle: TextStyle(
            fontFamily: fontsList[fontBloc],
            fontStyle: italicBloc ? FontStyle.italic : FontStyle.normal,
            fontSize: sizeBloc,
          ),
          onTap: (link) async {
            try {
              int lnk = int.parse(link.value!.replaceAll('#', ''));
              final value = await ReQueries().getRef(lnk);
              if (value.isNotEmpty) {
                String n = value[0].n.toString();
                String t = value[0].t.toString();
                int p = t.indexOf(' ');
                t = t.substring(p).trim();
                Map<String, String> data = {'header': n, 'contents': t};
                if (mounted) {
                  GetRef().refDialog(context, data);
                }
              }
            } catch (e) {
              debugPrint("Error in LinkifyText onTap: $e");
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to load reference')),
                );
              }
            }
          },
        ),
      );
    } else {
      return ListTile(
        title: Text(
          replaceNumbers(chapter.t!),
          style: TextStyle(
            fontFamily: fontsList[fontBloc],
            fontStyle: italicBloc ? FontStyle.italic : FontStyle.normal,
            fontSize: sizeBloc,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
          actions: [
            Switch(
              value: refsAreOn,
              onChanged: (bool value) {
                context.read<RefsBloc>().add(ChangeRefs(value));
                if (mounted) {
                  setState(() {
                    refsAreOn = value;
                  });
                }
              },
            ),
          ],
          title: Text(
            'Westminster',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: themeIsDark ? Colors.black : Colors.white,
            ),
            onPressed: () {
              Future.delayed(
                Duration(microseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          ),
        ),
        body: FutureBuilder<int>(
          future: weQueries.getChapterCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading chapters: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data == 0) {
              return const Center(child: Text('No chapters found.'));
            }
            final chapterCount = snapshot.data!;
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: PageView.builder(
                controller: pageController,
                itemCount: chapterCount,
                physics: const BouncingScrollPhysics(),
                pageSnapping: true,
                itemBuilder: (context, pageIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChapterPage(
                      chapterIndex: pageIndex,
                      refsAreOn: refsAreOn,
                      showListTile: showListTile,
                      // scroll to index only if it's the current page
                      //scrollToIndex: (pageIndex == pageNumber) ? indexNumber : 0,
                      scrollToIndex: context.read<ScrollBloc>().state,
                    ),
                  );
                },
                onPageChanged: (index) {
                  pageNumber = index + 1;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChapterPage extends StatefulWidget {
  final int chapterIndex;
  final bool refsAreOn;
  final Widget Function(Wesminster) showListTile;
  final int scrollToIndex;

  const ChapterPage({
    super.key,
    required this.chapterIndex,
    required this.refsAreOn,
    required this.showListTile,
    required this.scrollToIndex,
  });

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  final itemScrollController = ItemScrollController();

  // @override
  // void didUpdateWidget(covariant ChapterPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // Optionally handle updates if scrollToIndex changes
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Wesminster>>(
      future: weQueries.getChapter(widget.chapterIndex + 1),
      initialData: const [],
      builder: (context, chapterSnapshot) {
        if (chapterSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (chapterSnapshot.hasError) {
          return Center(
            child: Text('Error loading chapter: ${chapterSnapshot.error}'),
          );
        }
        final chapters = chapterSnapshot.data ?? [];
        if (chapters.isEmpty) {
          return const Center(child: Text('No content.'));
        }

        // Scroll after frame if scrollToIndex is set
        if (widget.scrollToIndex > 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (itemScrollController.isAttached) {
              itemScrollController
                  .scrollTo(
                    index: widget.scrollToIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  )
                  .then((v) {
                    if (context.mounted) {
                      context.read<ScrollBloc>().add(UpdateScroll(index: 0));
                    }
                  });
            }
          });
        }

        return ScrollablePositionedList.builder(
          itemCount: chapters.length,
          itemScrollController: itemScrollController,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return GestureDetector(
              child: widget.showListTile(chapter),
              onTap: () {
                final model = BmModel(
                  title: westindex[chapter.c! - 1],
                  subtitle: replaceNumbers(chapter.t!),
                  doc: 1,
                  page: chapter.c!,
                  para: index,
                );
                showPopupMenu(context, model);
              },
            );
          },
        );
      },
    );
  }
}
