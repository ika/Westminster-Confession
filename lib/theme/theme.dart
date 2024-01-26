import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/bloc/bloc_theme.dart';
import 'package:westminster_confession/utils/globals.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  ThemePageState createState() => ThemePageState();
}

class ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp
            ),
            onPressed: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        title: const Text('Theme Switcher',
            style: TextStyle(fontWeight: FontWeight.w700)),
        // actions: [
        //   Switch(
        //     value: (context.read<ThemeBloc>()) ? true : false,
        //     onChanged: (bool value) {
        //       context.read<ThemeBloc>().add(ChangeTheme(value));
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Switch between Light and Dark Themes:',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () =>
                      context.read<ThemeBloc>().add(ChangeTheme(false)),
                  child: const Text('Light'),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () =>
                      context.read<ThemeBloc>().add(ChangeTheme(true)),
                  child: const Text('Dark'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
