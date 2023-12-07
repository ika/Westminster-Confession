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
        debugShowCheckedModeBanner: false,
        title: 'Westminster Confession',
        // theme: FlexThemeData.light(scheme: FlexScheme.blumineBlue),
        // darkTheme: FlexThemeData.dark(scheme: FlexScheme.blumineBlue),

        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[200],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          //textTheme: const TextTheme(),
          // colorScheme: const ColorScheme(
          //   brightness: Brightness.light,
          //   primary: Color(0xff19647e),
          //   onPrimary: Color(0xffffffff),
          //   primaryContainer: Color(0xffa1cbcf),
          //   onPrimaryContainer: Color(0xff0e1111),
          //   secondary: Color(0xfffeb716),
          //   onSecondary: Color(0xff000000),
          //   secondaryContainer: Color(0xffffdea5),
          //   onSecondaryContainer: Color(0xff14120e),
          //   tertiary: Color(0xff0093c7),
          //   onTertiary: Color(0xffffffff),
          //   tertiaryContainer: Color(0xffc3e7ff),
          //   onTertiaryContainer: Color(0xff101314),
          //   error: Color(0xffb00020),
          //   onError: Color(0xffffffff),
          //   errorContainer: Color(0xfffcd8df),
          //   onErrorContainer: Color(0xff141213),
          //   background: Color(0xfff8fafb),
          //   onBackground: Color(0xff090909),
          //   surface: Color(0xfff8fafb),
          //   onSurface: Color(0xff090909),
          //   surfaceVariant: Color(0xffe2e6e7),
          //   onSurfaceVariant: Color(0xff111212),
          //   outline: Color(0xff7c7c7c),
          //   outlineVariant: Color(0xffc8c8c8),
          //   shadow: Color(0xff000000),
          //   scrim: Color(0xff000000),
          //   inverseSurface: Color(0xff111313),
          //   onInverseSurface: Color(0xfff5f5f5),
          //   inversePrimary: Color(0xffa9dbed),
          //   surfaceTint: Color(0xff19647e),
          // ),
        ),
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
