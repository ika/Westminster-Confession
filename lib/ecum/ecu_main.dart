import 'package:flutter/material.dart';
import 'package:westminster_confession/ecum/ecu_model.dart';
import 'package:westminster_confession/ecum/ecu_queries.dart';
import 'package:westminster_confession/ecum/ecu_page.dart';
import 'package:westminster_confession/utils/globals.dart';

// Ecumenical Creeds

CRQueries crQueries = CRQueries();

class ECUMain extends StatefulWidget {
  const ECUMain({super.key});

  @override
  ECUMainstate createState() => ECUMainstate();
}

class ECUMainstate extends State<ECUMain> {
  List<Creeds> chapters = List<Creeds>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Creeds>>(
      future: crQueries.getTitleList(),
      builder: (context, AsyncSnapshot<List<Creeds>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          return showChapterList(chapters, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  showChapterList(chapters, context) {
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
                Navigator.of(context)
                    .pushNamed('/ECUPage', arguments: ECUPageArguments(index));
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
      itemCount: chapters == null ? 0 : chapters.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(chapters, index);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
      leading: GestureDetector(
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
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
      title: const Text(
        'Ecumenical Creeds',
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
