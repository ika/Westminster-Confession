import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:westminster_confession/colors/col_palette.dart';
import 'package:westminster_confession/points/po_page.dart';
import 'package:westminster_confession/pref/pref_page.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/west/we_model.dart';
import 'package:westminster_confession/west/we_plain.dart';
import 'package:westminster_confession/west/we_proofs.dart';
import 'package:westminster_confession/west/we_queries.dart';

// The Westminster Confession

WEQueries weQueries = WEQueries();
MaterialColor? primarySwatch;

int r = 0;

Future<int> _read() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'routs';
  return prefs.getInt(key) ?? 0;
}

_save(int r) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'routs';
  final value = r;
  prefs.setInt(key, value);
}

class WeMain extends StatefulWidget {
  const WeMain({super.key});

  @override
  WeMainState createState() => WeMainState();
}

class WeMainState extends State<WeMain> {
  List<Wesminster> chapters = List<Wesminster>.empty();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _read().then(
      (value) {
        r = value;
      },
    );
  }

  onShareLink() async {
    await Share.share(
        'The Westminster Confession https://play.google.com/store/apps/details?id=org.armstrong.ika.westminster_confession');
  }

  drawerCode() {
    return Drawer(
      //backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  //color: Color.fromRGBO(64, 75, 96, .9),
                  color: Theme.of(context).drawerTheme.backgroundColor),
              child: Baseline(
                baseline: 50,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Index',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              'Bookmarks',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () => {Navigator.of(context).pushNamed(('/BMMain'))},
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              'Text Size',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () => {Navigator.of(context).pushNamed(('/TextSizePage'))},
          ),
          // ListTile(
          //   leading: const Icon(Icons.keyboard_double_arrow_right),
          //   title: const Text(
          //     'Colors',
          //     style: TextStyle(
          //       color: Colors.black87,
          //       fontFamily: 'Raleway-Regular',
          //       fontSize: 16,
          //     ),
          //   ),
          //   dense: true,
          //   onTap: () => {Navigator.of(context).pushNamed(('/ColorsPage'))},
          // ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              'Preface',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.of(context)
                      .pushNamed('/PrefPage', arguments: PrefPageArguments(0))
                      .then(
                    (value) {
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              'Five Points',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.of(context)
                      .pushNamed('/PointsPage', arguments: PointsArguments(0))
                      .then(
                    (value) {
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              'Ecumenical Creeds',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () => {Navigator.of(context).pushNamed(('/ECUMain'))},
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              'Larger Catechism',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () => {Navigator.of(context).pushNamed(('/CatMain'))},
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: r == 0
                ? Text(
                    'With Proofs',
                    style: Theme.of(context).textTheme.bodyLarge,
                    // style: TextStyle(
                    //   color: Colors.black87,
                    //   fontFamily: 'Raleway-Regular',
                    //   fontSize: 16,
                    // ),
                  )
                : Text(
                    'Without Proofs',
                    style: Theme.of(context).textTheme.bodyLarge,
                    // style: TextStyle(
                    //   color: Colors.black87,
                    //   fontFamily: 'Raleway-Regular',
                    //   fontSize: 16,
                    // ),
                  ),
            dense: true,
            onTap: () => {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (r == 0) {
                    _save(1);
                    setState(() {
                      r = 1;
                    });
                  } else {
                    _save(0);
                    setState(() {
                      r = 0;
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_double_arrow_right),
            title: Text(
              'Share',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: TextStyle(
              //   color: Colors.black87,
              //   fontFamily: 'Raleway-Regular',
              //   fontSize: 16,
              // ),
            ),
            dense: true,
            onTap: () => {Navigator.pop(context), onShareLink()},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Wesminster>>(
      future: weQueries.getTitleList('plain'),
      builder: (context, AsyncSnapshot<List<Wesminster>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white, //flexSchemeLight.surfaceVariant,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: flexSchemeLight.primary,
              leading: IconButton(
                icon: Icon(Icons.menu, color: flexSchemeLight.tertiary),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
              title: const Text(
                'Westminster Confession',
                style: TextStyle(color: Colors.white),
              ),
            ),
            drawer: drawerCode(),
            body: ListView.separated(
              itemCount: chapters.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  //selectedColor: flexSchemeLight.primaryContainer,
                  title: Text(
                    chapters[index].chap!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.linear_scale, color: flexSchemeLight.tertiary),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          //strutStyle: const StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                            text: " ${chapters[index].title!}",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right,
                      color: Colors.black, size: 20.0),
                  onTap: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        (r == 0)
                            ? Navigator.of(context).pushNamed('/WePlainPage',
                                arguments: WePlainArguments(index))
                            : Navigator.of(context).pushNamed('/WeProofsPage',
                                arguments: WeProofArguments(index));
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
