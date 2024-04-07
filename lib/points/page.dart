import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/bloc/bloc_font.dart';
import 'package:westminster_confession/bloc/bloc_italic.dart';
import 'package:westminster_confession/bloc/bloc_size.dart';
import 'package:westminster_confession/fonts/list.dart';
import 'package:westminster_confession/points/model.dart';
import 'package:westminster_confession/points/queries.dart';
import 'package:westminster_confession/utils/globals.dart';

// Preface

// class PrefPageArguments {
//   final int index;
//   PrefPageArguments(this.index);
// }

PointsQueries pointsQueries = PointsQueries();

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  PointsPageState createState() => PointsPageState();
}

class PointsPageState extends State<PointsPage> {
  List<Points> paragraphs = List<Points>.empty();
  String heading = "Five Points";

  // @override
  // void initState() {
  //   super.initState();
  //   primaryTextSize = BlocProvider.of<TextSizeCubit>(context).state;
  // }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as PrefPageArguments;

    return FutureBuilder<List<Points>>(
      future: pointsQueries.getPoints(),
      builder: (context, AsyncSnapshot<List<Points>> snapshot) {
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
                    title: Text(
                      paragraphs[index].h,
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontWeight: FontWeight.w700,
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
                    subtitle: Text(
                      paragraphs[index].t,
                      style: TextStyle(
                          fontFamily: fontsList[context.read<FontBloc>().state],
                          fontStyle: (context.read<ItalicBloc>().state)
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: context.read<SizeBloc>().state),
                    ),
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
