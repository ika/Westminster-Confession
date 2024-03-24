import 'package:flutter/material.dart';
import 'package:westminster_confession/pref/model.dart';
import 'package:westminster_confession/pref/queries.dart';
import 'package:westminster_confession/utils/globals.dart';

// Preface

// class PrefPageArguments {
//   final int index;
//   PrefPageArguments(this.index);
// }

PRQueries prQueries = PRQueries();

class PrefPage extends StatefulWidget {
  const PrefPage({super.key});

  @override
  PrefPageState createState() => PrefPageState();
}

class PrefPageState extends State<PrefPage> {
  List<Preface> paragraphs = List<Preface>.empty();
  String heading = "Preface";

  // @override
  // void initState() {
  //   super.initState();
  //   primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  // }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as PrefPageArguments;

    return FutureBuilder<List<Preface>>(
      future: prQueries.getParagraphs(),
      builder: (context, AsyncSnapshot<List<Preface>> snapshot) {
        if (snapshot.hasData) {
          paragraphs = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
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
              title: Text(heading,
                  style: const TextStyle(fontWeight: FontWeight.w700)
                  // style: const TextStyle(
                  //   color: Colors.yellow,
                  // ),
                  ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: paragraphs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    subtitle: Text(paragraphs[index].t!),
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
