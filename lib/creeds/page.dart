import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/bloc/bloc_font.dart';
import 'package:westminster_confession/bloc/bloc_italic.dart';
import 'package:westminster_confession/bloc/bloc_scroll.dart';
import 'package:westminster_confession/bloc/bloc_size.dart';
import 'package:westminster_confession/creeds/model.dart';
import 'package:westminster_confession/creeds/queries.dart';
import 'package:westminster_confession/fonts/list.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/menu.dart';

import '../bloc/bloc_theme.dart';

CreedsQueries creedsQueries = CreedsQueries();

class CreedsPage extends StatefulWidget {
  const CreedsPage({super.key});

  @override
  CreedsPageState createState() => CreedsPageState();
}

class CreedsPageState extends State<CreedsPage> {
  ItemScrollController initialScrollController = ItemScrollController();
  List<Creeds> paragraphs = List<Creeds>.empty();
  late bool themeIsDark;

  @override
  void initState() {
    super.initState();
    themeIsDark = context.read<ThemeBloc>().state;

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

    return FutureBuilder<List<Creeds>>(
      future: creedsQueries.getCreeds(),
      builder: (context, AsyncSnapshot<List<Creeds>> snapshot) {
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
                    color: themeIsDark ? Colors.black : Colors.white,
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
                'Ecumenical Creeds',
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
                    title: Text(
                      paragraphs[index].h,
                      style: TextStyle(
                        fontFamily: fontsList[context.read<FontBloc>().state],
                        fontWeight: FontWeight.w700,
                        fontStyle: (context.read<ItalicBloc>().state)
                            ? FontStyle.italic
                            : FontStyle.normal,
                        fontSize: context.read<SizeBloc>().state,
                      ),
                    ),
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
                        title: 'Ecumenical Creeds',
                        subtitle: paragraphs[index].t,
                        doc: 4,
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
