import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:westminster_confession/bkmarks/bm_main.dart';
import 'package:westminster_confession/bloc/bloc_theme.dart';
import 'package:westminster_confession/cat/cat_main.dart';
import 'package:westminster_confession/cat/cat_pages.dart';
import 'package:westminster_confession/ecum/ecu_main.dart';
import 'package:westminster_confession/ecum/ecu_page.dart';
import 'package:westminster_confession/points/po_page.dart';
import 'package:westminster_confession/pref/pref_page.dart';
import 'package:westminster_confession/theme/apptheme.dart';
import 'package:westminster_confession/theme/theme.dart';
import 'package:westminster_confession/west/we_main.dart';
import 'package:westminster_confession/west/we_plain.dart';
import 'package:westminster_confession/west/we_proofs.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const WestMinsterConfession());
}

class WestMinsterConfession extends StatelessWidget {
  const WestMinsterConfession({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Westminster Confession',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state ? ThemeMode.light : ThemeMode.dark,
            initialRoute: '/WeMain',
            routes: {
              '/WeMain': (context) => const WeMain(),
              '/WePlainPage': (context) => const WePlainPage(),
              '/WeProofsPage': (context) => const WeProofsPage(),
              '/BMMain': (context) => const BMMain(),
              '/PrefPage': (context) => const PrefPage(),
              '/PointsPage': (context) => const PointsPage(),
              '/ECUMain': (context) => const ECUMain(),
              '/ECUPage': (context) => const ECUPage(),
              '/CatMain': (context) => const CatMain(),
              '/ThemePage': (context) => const ThemePage(),
              '/CatPages': (context) => const CatPages()
            },
          );
        },
      ),
    );
  }
}
