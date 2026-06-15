part of 'index.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late bool isDark;

  @override
  void initState() {
    //isDark = widget.themeState;
    super.initState();
  }

  // Widget themeSwitcherIcon() {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         // toggle the theme state icon
  //         isDark = !isDark;
  //         context.read<ThemeBloc>().add(ChangeTheme(!isDark));
  //       });
  //     },
  //     child: AnimatedSwitcher(
  //       duration: const Duration(milliseconds: 300),
  //       transitionBuilder: (child, animation) =>
  //           RotationTransition(turns: animation, child: child),
  //       child: Icon(
  //         isDark ? Icons.dark_mode : Icons.light_mode,
  //         key: ValueKey<bool>(isDark),
  //         color: Theme.of(context).colorScheme.inversePrimary,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 220.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        child: Icon(
                          Icons.menu_book,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Contents',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // themeSwitcherIcon(),
                    ],
                  ),
                  // const Spacer(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [themeSwitcherIcon()],
                  // ),
                  // const Spacer(),
                  // Text(
                  //   'Welcome!',
                  //   style: TextStyle(
                  //     color: Theme.of(
                  //       context,
                  //     ).colorScheme.onPrimary.withValues(alpha: 0.8),
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark_border_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Bookmarks',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BMMarksPage(),
                      ),
                    );
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.text_fields_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Preface',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PrefPage()),
                    );
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.five_mp_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Five Points',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PointsPage(),
                      ),
                    );
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Creeds', style: Theme.of(context).textTheme.bodyLarge),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreedsPage(),
                      ),
                    );
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.school_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Catechism',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShorterPage(),
                      ),
                    );
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.school_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Theme Switcher',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThemePage(),
                      ),
                    );
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.font_download_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Fonts', style: Theme.of(context).textTheme.bodyLarge),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FontsPage(),
                      ),
                    );
                  }
                },
              );
            },
          ),
          if (Globals.isShareEnabled)
            ListTile(
              leading: Icon(
                Icons.share_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'Share',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              //dense: true,
              onTap: () {
                Future.delayed(
                  Duration(milliseconds: Globals.navigatorDelay),
                  () async {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    SharePlus.instance.share(
                      ShareParams(
                        uri: Uri.parse(
                          'https://play.google.com/store/apps/details?id=org.armstrong.ika.westminster_confession',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ListTile(
            leading: Icon(
              Icons.person_2_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'About',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            //dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutPage(),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
