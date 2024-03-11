import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:westminster_confession/bloc/bloc_refs.dart';
import 'package:westminster_confession/bloc/bloc_scroll.dart';
import 'package:westminster_confession/bloc/bloc_theme.dart';
import 'package:westminster_confession/main/index.dart';
import 'package:westminster_confession/theme/apptheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RefsBloc>(
          create: (context) => RefsBloc(),
        ),
        BlocProvider<ScrollBloc>(
          create: (context) => ScrollBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        )
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Westminster Confession',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state ? ThemeMode.light : ThemeMode.dark,
            home: const IndexPage(title: 'Index'),
          );
        },
      ),
    );
  }
}
