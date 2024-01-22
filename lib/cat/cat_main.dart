import 'package:flutter/material.dart';
import 'package:westminster_confession/cat/cat_model.dart';
import 'package:westminster_confession/cat/cat_pages.dart';
import 'package:westminster_confession/cat/cat_queries.dart';
import 'package:westminster_confession/utils/globals.dart';

// The Larger Catachism

CAQueries caQueries = CAQueries();

class CatMain extends StatefulWidget {
  const CatMain({super.key});

  @override
  CatMainState createState() => CatMainState();
}

class CatMainState extends State<CatMain> {
  List<Catachism> chapters = List<Catachism>.empty();

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Catachism>>(
      future: caQueries.getTitleList(),
      builder: (context, AsyncSnapshot<List<Catachism>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
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
              title: const Text(
                'Larger Catechism',
                // style: TextStyle(
                //   color: Colors.yellow,
                // ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: chapters.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // contentPadding: const EdgeInsets.symmetric(
                    //     horizontal: 20.0, vertical: 10.0),
                    title: Text(
                      chapters[index].chap!,
                      // style: const TextStyle(
                      //     color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.linear_scale, color: Theme.of(context).colorScheme.primary),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            //strutStyle: const StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                              text: " ${chapters[index].title!}",
                              //style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Theme.of(context).colorScheme.primary, size: 20.0),
                    onTap: () {
                      Future.delayed(
                        Duration(milliseconds: Globals.navigatorDelay),
                        () {
                          Navigator.of(context).pushNamed('/CatPages',
                              arguments: CatPageArguments(index));
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
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
