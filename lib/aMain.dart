import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:westminster_confession/xMain.dart';
import 'package:share/share.dart';

import 'aDetailPage.dart';
import 'bMain.dart';
import 'cDetailPage.dart';
import 'dDetailPage.dart';
import 'dbHelper.dart';
import 'dbModel.dart';
import 'eMain.dart';
import 'fDetailPage.dart';

// The Westminster Confession

int r;

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

class AMain extends StatefulWidget {
  const AMain({Key key}) : super(key: key);

  @override
  _AMainState createState() => _AMainState();
}

class _AMainState extends State<AMain> {
  DBProvider dbProvider = DBProvider();
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
      future: dbProvider.getTitleList('atexts'),
      builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data;
          return showChapterList(chapters, context);
        } else {
          return const CircularProgressIndicator();
        }
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
                      text: " " + chapters[index].title),
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Future.delayed(
              const Duration(milliseconds: 200),
              () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => (r == 0)
                            ? ADetailPage(index)
                            : FDetailPage(index)));
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

    _onShareLink(BuildContext context) async {
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
              height: 100.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 75, 96, .9),
                ),
                child: Text(
                  'Index',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontFamily: 'Raleway-Regular',
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.blueGrey),
              title: const Text('Preface'),
              dense: true,
              onTap: () => {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => CDetailPage(0)));
                  },
                ),
              },
            ),
            ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.blueGrey,
              ),
              title: const Text('Ecumenical Creeds'),
              dense: true,
              onTap: () => {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const BMain()));
                  },
                ),
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.blueGrey),
              title: const Text('The Five Points'),
              dense: true,
              onTap: () => {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => DDetailPage(0)));
                  },
                ),
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.blueGrey),
              title: const Text('The Larger Catechism'),
              dense: true,
              onTap: () => {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const XMain()));
                  },
                ),
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.blueGrey),
              title: r == 0
                  ? const Text('With Scripture Proofs')
                  : const Text('As Plain Text'),
              dense: true,
              onTap: () => {
                Future.delayed(
                  const Duration(milliseconds: 200),
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
              trailing: const Icon(Icons.bookmarks, color: Colors.blueGrey),
              title: const Text('Bookmarks'),
              dense: true,
              onTap: () => {
                Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const EMain()));
                  },
                ),
              },
            ),
            ListTile(
              trailing: const Icon(Icons.share, color: Colors.blueGrey),
              title: const Text('Share this App'),
              dense: true,
              onTap: () => {Navigator.pop(context), _onShareLink(context)},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: chapters == null ? 0 : chapters.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(chapters, index);
        },
      ),
    );
  }
}
