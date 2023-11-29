import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:westminster_confession/main/ma_queries.dart';
import 'package:westminster_confession/utils/globals.dart';

import '../main/ma_helper.dart';
import '../main/ma_model.dart';
import 'cat_pages.dart';

// The Larger Catachism

DBQueries dbQueries = DBQueries();

class CatMain extends StatefulWidget {
  const CatMain({super.key});

  @override
  CatMainState createState() => CatMainState();
}

class CatMainState extends State<CatMain> {
  DBProvider dbProvider = DBProvider();
  List<Chapter> chapters = List<Chapter>.empty();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
      future: dbQueries.getTitleList('etexts'),
      builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          return showChapterList(chapters, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  showChapterList(List<Chapter> chapters, context) {
    ListTile makeListTile(chapters, int index) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            chapters[index].chap,
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
                      text: " ${chapters[index].title}"),
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Future.delayed(
              Duration(milliseconds: Globals.navigatorDelay),
              () {
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => CatPages(index)));
                Navigator.of(context)
                    .pushNamed('/CatPages', arguments: CatPageArguments(index));
              },
            );
          },
        );

    Card makeCard(chapters, int index) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(chapters, index),
          ),
        );

    final makeBody = ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: chapters.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(chapters, index);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
      title: const Text(
        'Larger Catechism',
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
