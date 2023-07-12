import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:westminster_confession/bkmarks/bm_main.dart';
import 'package:westminster_confession/cat/cat_main.dart';
import 'package:westminster_confession/ecum/ecu_main.dart';
import 'package:westminster_confession/main/ma_model.dart';
import 'package:westminster_confession/main/ma_queries.dart';
import 'package:westminster_confession/points/po_page.dart';
import 'package:westminster_confession/pref/pref_page.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/west/we_plain.dart';
import 'package:westminster_confession/west/we_proofs.dart';

// The Westminster Confession

DBQueries dbQueries = DBQueries();

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
  const WeMain({Key? key}) : super(key: key);

  @override
  WeMainState createState() => WeMainState();
}

class WeMainState extends State<WeMain> {
  List<Chapter> chapters = List<Chapter>.empty();

  @override
  void initState() {
    super.initState();

    _read().then(
      (value) {
        r = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
      future: dbQueries.getTitleList('atexts'),
      builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          return showChapterList(chapters, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  goToFunction(BuildContext context, Widget route) {
    Future.delayed(
      Duration(milliseconds: Globals.navigatorDelay),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        ).then((value) {
          setState(() {});
        });
      },
    );
  }

  showChapterList(List<Chapter> chapters, context) {
    ListTile makeListTile(chapters, int index) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            chapters[index].chap,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              const Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: const StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      text: " ${chapters[index].title}"),
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Future.delayed(
              Duration(milliseconds: Globals.navigatorDelay),
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (r == 0)
                            ? WePlainPage(index)
                            : WeProofsPage(index)));
              },
            );
          },
        );

    Card makeCard(chapters, int index) => Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(chapters, index),
          ),
        );

    onShareLink(BuildContext context) async {
      await Share.share(
          'The Westminster Confession https://play.google.com/store/apps/details?id=org.armstrong.ika.westminster_confession');
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        title: const Text(
          'Westminster Confession',
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 120.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 75, 96, .9),
                ),
                child: Baseline(
                  baseline: 50,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    'Index',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: 'Raleway-Regular',
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_double_arrow_right),
              title: const Text(
                'Bookmarks',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),
              ),
              dense: true,
              onTap: () => {
                goToFunction(context, const BMMain())
              },
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_double_arrow_right),
              title: const Text('Preface',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),),
              dense: true,
              onTap: () => {
                goToFunction(context, PrefPage(0))
              },
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_double_arrow_right),
              title: const Text('Five Points',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),),
              dense: true,
              onTap: () => {
                goToFunction(context, PointsPage(0))
              },
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_double_arrow_right),
              title: const Text('Ecumenical Creeds',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),),
              dense: true,
              onTap: () => {
                goToFunction(context, const ECUMain())
              },
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_double_arrow_right),
              title: r == 0
                  ? const Text('Scripture Proofs',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),)
                  : const Text('Plain Text',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),),
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
              title: const Text('Larger Catechism',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),),
              dense: true,
              onTap: () => {
                goToFunction(context, const CatMain())
              },
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_double_arrow_right),
              title: const Text('Share this App',style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Raleway-Regular',
                fontSize: 16,
              ),),
              dense: true,
              onTap: () => {Navigator.pop(context), onShareLink(context)},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: chapters.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(chapters, index);
        },
      ),
    );
  }
}
