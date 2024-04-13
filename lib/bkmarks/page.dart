import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/bkmarks/queries.dart';
import 'package:westminster_confession/bloc/bloc_scroll.dart';
import 'package:westminster_confession/main/page.dart';
import 'package:westminster_confession/utils/globals.dart';

// Bookmarks

final BMQueries bmQueries = BMQueries();

Future confirmDialog(BuildContext context, List list, int index) async {
  return showDialog(
    builder: (context) => AlertDialog(
      title: const Text('Delete bookmark?'), // title
      content:
          Text("${list[index].title}\n${list[index].subtitle}"), // subtitle
      actions: [
        TextButton(
          child:
              const Text('YES', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TextButton(
          child:
              const Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    ),
    context: context,
  );
}

class BMMarksPage extends StatefulWidget {
  const BMMarksPage({super.key});

  @override
  BMMarksPageState createState() => BMMarksPageState();
}

class BMMarksPageState extends State<BMMarksPage> {
  List<BmModel> list = List<BmModel>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BmModel>>(
      future: bmQueries.getBookMarkList(),
      builder: (context, AsyncSnapshot<List<BmModel>> snapshot) {
        if (snapshot.hasData) {
          list = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
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
              title: const Text('Bookmarks',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0 ||
                          details.primaryVelocity! < 0) {
                        confirmDialog(context, list, index).then((value) {
                          if (value) {
                            bmQueries
                                .deleteBookMark(list[index].id!)
                                .then((value) {
                              setState(() {});
                            });
                          }
                        });
                      }
                    },
                    child: ListTile(
                      // contentPadding: const EdgeInsets.symmetric(
                      //     horizontal: 20.0, vertical: 10.0),
                      title: Text(
                        list[index].title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.linear_scale,
                              color: Theme.of(context).colorScheme.primary),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              //strutStyle: const StrutStyle(fontSize: 12.0),
                              text: TextSpan(
                                text: " ${list[index].subtitle}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0),
                      onTap: () {
                        context.read<ScrollBloc>().add(
                              UpdateScroll(index: list[index].para),
                            );
                        //int page = list[index].page;

                        //Navigator.of(context).pop();

                        // pop before return
                        int c = 0;
                        Navigator.of(context).popUntil((route) => c++ == 2);

                        Future.delayed(
                          Duration(milliseconds: Globals.navigatorDelay),
                          // () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           ProofsPage(page: list[index].page),
                          //     ),
                          //   ).then(
                          //     (value) {
                          //       int c = 0;
                          //       Navigator.of(context)
                          //           .popUntil((route) => c++ >= 2);
                          //     },
                          //   );
                          // },
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProofsPage(page: list[index].page),
                              ),
                            );
                          },
                        );

                        // switch (list[index].detail) {
                        //   case "1": // Westminster plain text
                        //     Future.delayed(
                        //       Duration(milliseconds: Globals.navigatorDelay),
                        //       () {
                        //         Navigator.of(context)
                        //             .pushNamed('/WePlainPage',
                        //                 arguments: WePlainArguments(goto))
                        //             .then(
                        //           (value) {
                        //             int count = 1;
                        //             Navigator.of(context)
                        //                 .popUntil((_) => count++ >= 2);
                        //           },
                        //         );
                        //       },
                        //     );
                        //     break;

                        //   case "2": // Ecumenical Creeds
                        //     Future.delayed(
                        //       Duration(milliseconds: Globals.navigatorDelay),
                        //       () {
                        //         Navigator.of(context)
                        //             .pushNamed('/ECUPage',
                        //                 arguments: ECUPageArguments(goto))
                        //             .then(
                        //           (value) {
                        //             int count = 1;
                        //             Navigator.of(context)
                        //                 .popUntil((_) => count++ >= 2);
                        //           },
                        //         );
                        //       },
                        //     );

                        //     break;

                        //   case "3": // Preface
                        //     Future.delayed(
                        //       Duration(milliseconds: Globals.navigatorDelay),
                        //       () {
                        //         Navigator.of(context)
                        //             .pushNamed('/PrefPage',
                        //                 arguments: PrefPageArguments(goto))
                        //             .then(
                        //           (value) {
                        //             int count = 1;
                        //             Navigator.of(context)
                        //                 .popUntil((_) => count++ >= 2);
                        //           },
                        //         );
                        //       },
                        //     );
                        //     break;

                        //   case "4": // Five Points
                        //     Future.delayed(
                        //       Duration(milliseconds: Globals.navigatorDelay),
                        //       () {
                        //         Navigator.of(context)
                        //             .pushNamed('/PointsPage',
                        //                 arguments: PointsArguments(goto))
                        //             .then(
                        //           (value) {
                        //             int count = 1;
                        //             Navigator.of(context)
                        //                 .popUntil((_) => count++ >= 2);
                        //           },
                        //         );
                        //       },
                        //     );
                        //     break;
                        //   case "5": // Westminster with proofs
                        //     Future.delayed(
                        //       Duration(milliseconds: Globals.navigatorDelay),
                        //       () {
                        //         Navigator.of(context)
                        //             .pushNamed('/WeProofsPage',
                        //                 arguments: WeProofArguments(goto))
                        //             .then(
                        //           (value) {
                        //             int count = 1;
                        //             Navigator.of(context)
                        //                 .popUntil((_) => count++ >= 2);
                        //           },
                        //         );
                        //       },
                        //     );
                        //     break;
                        //   case "6": // Larger Catechism
                        //     Future.delayed(
                        //       Duration(milliseconds: Globals.navigatorDelay),
                        //       () {
                        //         Navigator.of(context)
                        //             .pushNamed('/CatPages',
                        //                 arguments: CatPageArguments(goto))
                        //             .then(
                        //           (value) {
                        //             int count = 1;
                        //             Navigator.of(context)
                        //                 .popUntil((_) => count++ >= 2);
                        //           },
                        //         );
                        //       },
                        //     );
                        //     break;
                        // }
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
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
