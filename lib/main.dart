import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:westminster_confession/bkmarks/bm_main.dart';
import 'package:westminster_confession/cat/cat_main.dart';
import 'package:westminster_confession/cat/cat_pages.dart';
import 'package:westminster_confession/cubit/cub_size.dart';
import 'package:westminster_confession/ecum/ecu_main.dart';
import 'package:westminster_confession/ecum/ecu_page.dart';
import 'package:westminster_confession/points/po_page.dart';
import 'package:westminster_confession/pref/pref_page.dart';
import 'package:westminster_confession/size/tx_size.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/shared_prefs.dart';
import 'package:westminster_confession/west/we_main.dart';
import 'package:westminster_confession/west/we_plain.dart';
import 'package:westminster_confession/west/we_proofs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs().getDoublePref('textSize').then((t) {
    Globals.initialTextSize = t ?? 16.0;
    runApp(const WestMinsterConfession());
  });
}

class WestMinsterConfession extends StatelessWidget {
  const WestMinsterConfession({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
        brightness: MediaQuery.platformBrightnessOf(context),
        seedColor: Colors.indigo);

    ThemeData lightTheme = ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.tertiary,
          foregroundColor: colorScheme.onTertiary,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        fontFamily: 'Raleway-Regular',
        listTileTheme: ListTileThemeData(
          //textColor: Colors.black54, 
          iconColor: colorScheme.tertiary,
          //titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          
        );


    return MultiBlocProvider(
      providers: [
        BlocProvider<TextSizeCubit>(
          create: (context) => TextSizeCubit()..getSize(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Westminster Confession',
        theme: lightTheme,
        themeMode: ThemeMode.light,
        initialRoute: '/WeMain',
        routes: {
          '/WeMain': (context) => const WeMain(),
          '/WePlainPage': (context) => const WePlainPage(),
          '/WeProofsPage': (context) => const WeProofsPage(),
          '/BMMain': (context) => const BMMain(),
          '/TextSizePage': (context) => const TextSizePage(),
          '/PrefPage': (context) => const PrefPage(),
          '/PointsPage': (context) => const PointsPage(),
          '/ECUMain': (context) => const ECUMain(),
          '/ECUPage': (context) => const ECUPage(),
          '/CatMain': (context) => const CatMain(),
          '/CatPages': (context) => const CatPages()
          //'/ColorsPage': (context) => const ColorsPage()
        },
      ),
    );
  }
}
