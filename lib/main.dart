import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs().getDoublePref('textSize').then((t) {
    Globals.initialTextSize = t ?? 16.0;
    runApp(const WestMinsterConfession());
  });
}

class WestMinsterConfession extends StatelessWidget {
  const WestMinsterConfession({super.key});

  // Used to select if we use the dark or light theme, start with system mode.
  //ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    // final theme = FlexThemeData.light(
    //   scheme: FlexScheme.red,
    //   // Use very subtly themed app bar elevation in light mode.
    //   appBarElevation: 0.5,
    //   useMaterial3: true,
    //   // We use the nicer Material-3 Typography in both M2 and M3 mode.
    //   typography: Typography.material2021(platform: defaultTargetPlatform),
    // );

    return MultiBlocProvider(
      providers: [
        BlocProvider<TextSizeCubit>(
          create: (context) => TextSizeCubit()..getSize(),
        ),
        // BlocProvider<ColorsCubit>(
        //   create: (context) => ColorsCubit(),
        // )
      ],
      // child: BlocBuilder<ColorsCubit, ColorsState>(
      //   builder: ((context, state) {
      child: MaterialApp(
        // theme: FlexThemeData.light(scheme: FlexScheme.blumineBlue),
        // darkTheme: FlexThemeData.dark(scheme: FlexScheme.blumineBlue),
        // themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'Westminster Confession',
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
