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
        },
      ),
    );
  }
}
