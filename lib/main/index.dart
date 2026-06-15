import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:westminster_confession/about/page.dart';
import 'package:westminster_confession/bkmarks/page.dart';
import 'package:westminster_confession/creeds/page.dart';
import 'package:westminster_confession/fonts/fonts.dart';
import 'package:westminster_confession/main/page.dart';
import 'package:westminster_confession/points/page.dart';
import 'package:westminster_confession/shorter/page.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/utils.dart';
import 'package:westminster_confession/pref/page.dart';
import 'package:westminster_confession/theme/theme.dart';

part 'drawer.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  List<String> westindex = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: Utils().getTitleList(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          westindex = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: true,
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0,
            //   centerTitle: true,
            //   title: Text(
            //     'Chapters',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w700,
            //       color: Theme.of(context).colorScheme.onPrimary,
            //       fontSize: 26,
            //       letterSpacing: 1.2,
            //     ),
            //   ),
            //   leading: IconButton(
            //     icon: Icon(
            //       Icons.menu,
            //       color: Theme.of(context).colorScheme.onPrimary,
            //     ),
            //     onPressed: () {
            //       Future.delayed(
            //         Duration(milliseconds: Globals.navigatorDelay),
            //         () {
            //           scaffoldKey.currentState!.openDrawer();
            //         },
            //       );
            //     },
            //   ),
            // ),
            drawer: AppDrawer(),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.surface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                  bottom: 8,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      floating: true,
                      snap: true,
                      title: Text(
                        'Chapters',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
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
                    SliverList(
                      delegate: SliverChildBuilderDelegate((
                        BuildContext context,
                        int index,
                      ) {
                        int num = index + 1;

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          color: Theme.of(context).colorScheme.outline,
                          child: ListTile(
                            //tileColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            title: Text(
                              "Chapter $num:",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  Icons.linear_scale,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Flexible(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: " ${westindex[index]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right,
                              color: Theme.of(context).colorScheme.primary,
                              size: 24.0,
                            ),
                            onTap: () {
                              Future.delayed(
                                Duration(milliseconds: Globals.navigatorDelay),
                                () {
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProofsPage(page: index),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                      }, childCount: westindex.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
