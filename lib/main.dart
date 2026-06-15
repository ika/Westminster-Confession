import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:westminster_confession/bloc/bloc_font.dart';
import 'package:westminster_confession/bloc/bloc_italic.dart';
import 'package:westminster_confession/bloc/bloc_refs.dart';
import 'package:westminster_confession/bloc/bloc_scroll.dart';
import 'package:westminster_confession/bloc/bloc_size.dart';
import 'package:westminster_confession/bloc/bloc_theme.dart';
import 'package:westminster_confession/main/index.dart';
import 'package:westminster_confession/theme/apptheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
        (await getApplicationDocumentsDirectory()).path),
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
        ),
        BlocProvider<FontBloc>(
          create: (context) => FontBloc(),
        ),
        BlocProvider<ItalicBloc>(
          create: (context) => ItalicBloc(),
        ),
        BlocProvider<SizeBloc>(
          create: (context) => SizeBloc(),
        )
      ],
      child: BlocBuilder<ThemeBloc, int>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Westminster Confession',
            theme: selectTheme(state),
            home: const IndexPage(),
          );
        },
      ),
    );
  }
}
