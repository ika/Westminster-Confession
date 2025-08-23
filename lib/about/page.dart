import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/bloc/bloc_font.dart';
import 'package:westminster_confession/bloc/bloc_italic.dart';
import 'package:westminster_confession/bloc/bloc_size.dart';
import 'package:westminster_confession/fonts/list.dart';
import 'package:westminster_confession/about/model.dart';
import 'package:westminster_confession/about/queries.dart';
import 'package:westminster_confession/utils/globals.dart';

import '../bloc/bloc_theme.dart';

// About

AbQueries abQueries = AbQueries();

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  List<About> paragraphs = List<About>.empty();
  late bool themeIsDark;

  @override
  void initState() {
    themeIsDark = context.read<ThemeBloc>().state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<About>>(
      future: abQueries.getParagraphs(),
      builder: (context, AsyncSnapshot<List<About>> snapshot) {
        if (snapshot.hasData) {
          paragraphs = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.surface],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              leading: GestureDetector(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: themeIsDark ? Colors.black : Colors.white,
                  ),
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: Globals.navigatorDelay), () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              title: Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: paragraphs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      paragraphs[index].h!,
                      style: TextStyle(
                        fontFamily: fontsList[context.read<FontBloc>().state],
                        fontWeight: FontWeight.w700,
                        fontStyle: (context.read<ItalicBloc>().state) ? FontStyle.italic : FontStyle.normal,
                        fontSize: context.read<SizeBloc>().state,
                      ),
                    ),
                    subtitle: Text(
                      paragraphs[index].t!,
                      style: TextStyle(
                        fontFamily: fontsList[context.read<FontBloc>().state],
                        fontStyle: (context.read<ItalicBloc>().state) ? FontStyle.italic : FontStyle.normal,
                        fontSize: context.read<SizeBloc>().state,
                      ),
                    ),
                  );
                },
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
