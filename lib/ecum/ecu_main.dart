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
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    //color: Colors.black,
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
                // style: TextStyle(
                // color: Colors.black,
                // ),
              ),
            ),
            body: ListView.separated(
              itemCount: chapters.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    chapters[index].chap!,
                    //style: const TextStyle(
                    //    color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.linear_scale),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          //strutStyle: const StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                              text: " ${chapters[index].title}",
                              style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right,
                      color: Colors.black, size: 20.0),
                  onTap: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        Navigator.of(context).pushNamed('/ECUPage',
                            arguments: ECUPageArguments(index));
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
