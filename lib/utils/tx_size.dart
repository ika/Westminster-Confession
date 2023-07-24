import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/cubit/cub_text.dart';
import 'package:westminster_confession/utils/shared_prefs.dart';

//MaterialColor? primarySwatch;
SharedPrefs sharedPrefs = SharedPrefs();

class TextSizePage extends StatefulWidget {
  const TextSizePage({Key? key}) : super(key: key);

  @override
  State<TextSizePage> createState() => _TextSizePageState();
}

class _TextSizePageState extends State<TextSizePage> {

  List<double> sizesList = [14, 16, 18, 20, 22, 24, 26, 28];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        title: const Text(
          'Text Size',
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            for (int i = 0; i < sizesList.length; i++)
              InkWell(
                onTap: () {
                  double tsize = sizesList[i].toDouble();
                  sharedPrefs.setDoublePref('textSize', tsize).then((value) {
                    if (value) {
                      BlocProvider.of<TextSizeCubit>(context).setSize(tsize);
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
                  height: 55,
                  color: Colors.yellow,
                  child: Center(
                    child: Text(
                      'In the beginning',
                      style: TextStyle(
                        fontSize: sizesList[i],
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
