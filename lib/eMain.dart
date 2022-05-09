import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:westminster_confession/xDetailPage.dart';

import 'aDetailPage.dart';
import 'bDetailPage.dart';
import 'bmHelper.dart';
import 'bmModel.dart';
import 'cDetailPage.dart';
import 'dDetailPage.dart';
import 'fDetailPage.dart';

// Bookmarks

enum ConfirmAction { CANCEL, ACCEPT }

BMProvider bmProvider = BMProvider();

Future _showDialog(context, list) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete this bookmark?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(list.subtitle),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('YES', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          ),
          TextButton(
            child: const Text('NO', style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
        ],
      );
    },
  );
}

class EMain extends StatefulWidget {
  const EMain({Key key}) : super(key: key);

  @override
  _EMainState createState() => _EMainState();
}

class _EMainState extends State<EMain> {
  List<BMModel> list = List<BMModel>.empty();
  BMModel model;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BMModel>>(
      future: bmProvider.getBookMarkList(),
      builder: (context, AsyncSnapshot<List<BMModel>> snapshot) {
        if (snapshot.hasData) {
          list = snapshot.data;
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
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      text: " " + list[index].subtitle),
                ),
              ),
            ],
          ),
          trailing:
              const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            int goto = int.parse(list[index].page);
            switch (list[index].detail) {
              case "1": // Westminster prain text
                {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ADetailPage(goto)))
                      .then((value) {
                    setState(() {});
                  });
                }
                break;

              case "2": // Ecumenical Creeds
                {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => BDetailPage(goto)))
                      .then((value) {
                    setState(() {});
                  });
                }
                break;

              case "3": // Preface
                {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CDetailPage(goto)))
                      .then((value) {
                    setState(() {});
                  });
                }
                break;

              case "4": // Five Points
                {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => DDetailPage(goto)))
                      .then((value) {
                    setState(() {});
                  });
                }
                break;
              case "5": // Westminster with proofs
                {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => FDetailPage(goto)))
                      .then((value) {
                    setState(() {});
                  });
                }
                break;
              case "6": // Larger Catechism
                {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => XDetailPage(goto)))
                      .then((value) {
                    setState(() {});
                  });
                }
                break;
            }
          },
          onLongPress: () {
            _showDialog(context, list[index]).then((value) {
              if (value == ConfirmAction.ACCEPT) {
                bmProvider.deleteBookMark(list[index].id).then((value) {
                  setState(() {
                    list.removeAt(index);
                  });
                });
              }
            });
          },
        );

    Card makeCard(list, int index) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Container(
            decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(list, index),
          ),
        );

    final makeBody = ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(list, index);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
      title: const Text('Bookmarks'),
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
    );
  }
}
