import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/cubit/cub_text.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/shared_prefs.dart';
import 'package:westminster_confession/west/we_main.dart';

SharedPrefs sharedPrefs = SharedPrefs();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs.getDoublePref('textSize').then((t) {
    Globals.initialTextSize = t ?? 16.0;
    runApp(const WestMinsterConfession());
  });
}

class WestMinsterConfession extends StatelessWidget {
  const WestMinsterConfession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextSizeCubit>(
          create: (context) => TextSizeCubit()..getSize(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Westminster Confession',
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(58, 66, 86, 1.0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const WeMain(),
      ),
    );
  }
}
