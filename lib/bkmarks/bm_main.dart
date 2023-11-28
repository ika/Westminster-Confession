import 'package:flutter/material.dart';
import 'package:westminster_confession/bkmarks/bm_model.dart';
import 'package:westminster_confession/bkmarks/bm_queries.dart';
import 'package:westminster_confession/cat/cat_pages.dart';
import 'package:westminster_confession/ecum/ecu_page.dart';
import 'package:westminster_confession/points/po_page.dart';
import 'package:westminster_confession/pref/pref_page.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/west/we_plain.dart';
import 'package:westminster_confession/west/we_proofs.dart';

// Bookmarks

final BMQueries bmQueries = BMQueries();

Future confirmDialog(BuildContext context, List list, int index) async {
  return showDialog(
    builder: (context) => AlertDialog(
      title: const Text('Delete this bookmark?'), // title
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

class BMMain extends StatefulWidget {
  const BMMain({Key? key}) : super(key: key);

  @override
  BMMainState createState() => BMMainState();
}

class BMMainState extends State<BMMain> {
  List<BMModel> list = List<BMModel>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BMModel>>(
      future: bmQueries.getBookMarkList(),
      builder: (context, AsyncSnapshot<List<BMModel>> snapshot) {
        if (snapshot.hasData) {
          list = snapshot.data!;
          return showChapterList(list, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  showChapterList(list, context) {
    ListTile makeListTile(list, int index) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            list[index].title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              const Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: const StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      text: " ${list[index].subtitle}"),
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            int goto = int.parse(list[index].page);

            switch (list[index].detail) {
              case "1": // Westminster plain text
                Future.delayed(Duration(milliseconds: Globals.navigatorDelay),
                    () {
                  Navigator.of(context)
                      .pushNamed('/wePlain', arguments: WePlainArguments(goto))
                      .then(
                    (value) {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                  );
                }
                    // {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => WePlainPage(goto),
                    //     ),
                    //   ).then((value) {
                    //     int count = 1;
                    //     Navigator.of(context).popUntil((_) => count++ >= 2);
                    //   });
                    // },
                    );
                break;

              case "2": // Ecumenical Creeds
                Future.delayed(
                  Duration(milliseconds: Globals.navigatorDelay),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ECUPage(goto),
                      ),
                    ).then((value) {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    });
                  },
                );

                break;

              case "3": // Preface
                Future.delayed(
                  Duration(milliseconds: Globals.navigatorDelay),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrefPage(goto),
                      ),
                    ).then((value) {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    });
                  },
                );
                break;

              case "4": // Five Points
                Future.delayed(
                  Duration(milliseconds: Globals.navigatorDelay),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PointsPage(goto),
                      ),
                    ).then((value) {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    });
                  },
                );
                break;
              case "5": // Westminster with proofs
                Future.delayed(Duration(milliseconds: Globals.navigatorDelay),
                    () {
                  Navigator.of(context)
                      .pushNamed('/weProofs', arguments: WeProofArguments(goto))
                      .then(
                    (value) {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                  );
                }
                    //()
                    // {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => WeProofsPage(goto),
                    //     ),
                    //   ).then((value) {
                    //     int count = 1;
                    //     Navigator.of(context).popUntil((_) => count++ >= 2);
                    //   });
                    // },
                    );
                break;
              case "6": // Larger Catechism
                Future.delayed(
                  Duration(milliseconds: Globals.navigatorDelay),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatPages(goto),
                      ),
                    ).then((value) {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    });
                  },
                );
                break;
            }
          },
        );

    Card makeCard(list, int index) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(list, index),
          ),
        );

    final makeBody = ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0 ||
                  details.primaryVelocity! < 0) {
                confirmDialog(context, list, index).then((value) {
                  if (value) {
                    bmQueries.deleteBookMark(list[index].id).then((value) {
                      setState(() {
                        list.removeAt(index);
                      });
                    });
                  }
                });
              }
            },
            child: makeCard(list, index));
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
      title: const Text(
        'Bookmarks',
        style: TextStyle(
          color: Colors.yellow,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
    );
  }
}
