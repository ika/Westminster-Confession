import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/about/page.dart';
import 'package:westminster_confession/bkmarks/page.dart';
import 'package:westminster_confession/bloc/bloc_chapter.dart';
import 'package:westminster_confession/creeds/page.dart';
import 'package:westminster_confession/fonts/fonts.dart';
import 'package:westminster_confession/main/page.dart';
import 'package:westminster_confession/points/page.dart';
import 'package:westminster_confession/shorter/page.dart';
import 'package:westminster_confession/theme/theme.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/utils.dart';
import 'package:westminster_confession/pref/page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, required this.title});

  final String title;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<String> westindex = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  drawerCode() {
    return Drawer(
      //backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200.0,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                  //color: Theme.of(context).colorScheme.inversePrimary
                  ),
              child: Baseline(
                baseline: 80,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Index',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
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
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BMMarksPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrefPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PointsPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Creeds',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreedsPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Catechism',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShorterPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Fonts',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FontsPage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Theme',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemePage(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.keyboard_double_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'About',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // reset scrollto
    // context.read<ScrollBloc>().add(
    //       UpdateScroll(index: 0),
    //     );
    // reset chapter
    context.read<ChapterBloc>().add(
          UpdateChapter(chapter: 1),
        );
    return FutureBuilder<List<String>>(
      future: Utils().getTitleList(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          westindex = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                    );
                  },
                ),
              ),
              title: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            drawer: drawerCode(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ListView.separated(
                  itemCount: westindex.length,
                  itemBuilder: (BuildContext context, int index) {
                    int num = index + 1;
                    return ListTile(
                      title: Text(
                        "Chapter $num:",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.linear_scale,
                              color: Theme.of(context).colorScheme.primary),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: " ${westindex[index]}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0),
                      onTap: () {
                        Future.delayed(
                          Duration(milliseconds: Globals.navigatorDelay),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProofsPage(page: index),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
