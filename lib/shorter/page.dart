import 'package:flutter/material.dart';
import 'package:westminster_confession/shorter/model.dart';
import 'package:westminster_confession/shorter/queries.dart';
import 'package:westminster_confession/utils/globals.dart';

// Preface

// class PrefPageArguments {
//   final int index;
//   PrefPageArguments(this.index);
// }

ShorterQueries shorterQueries = ShorterQueries();

class ShorterPage extends StatefulWidget {
  const ShorterPage({super.key});

  @override
  ShorterPageState createState() => ShorterPageState();
}

class ShorterPageState extends State<ShorterPage> {
  
  List<Shorter> paragraphs = List<Shorter>.empty();
  String heading = "Shorter Catechism";

  // @override
  // void initState() {
  //   super.initState();
  //   primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  // }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as PrefPageArguments;

    return FutureBuilder<List<Shorter>>(
      future: shorterQueries.getShorter(),
      builder: (context, AsyncSnapshot<List<Shorter>> snapshot) {
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
                    title: Text(paragraphs[index].h),
                    subtitle: Text(paragraphs[index].t),
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
