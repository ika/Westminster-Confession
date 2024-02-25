import 'package:flutter/material.dart';
import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/queries.dart';
import 'package:linkfy_text/linkfy_text.dart';

//bool? initialPageScroll;

class ProofsPage extends StatefulWidget {
  const ProofsPage({super.key});

  @override
  State<ProofsPage> createState() => _ProofsPageState();
}

class _ProofsPageState extends State<ProofsPage> {
  List<Wesminster> chapters = List<Wesminster>.empty();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Wesminster>>(
      future: WeQueries().getChapters(),
      builder: (context, AsyncSnapshot<List<Wesminster>> snapshot) {
        if (snapshot.hasData) {
          chapters = snapshot.data!;
          PageController pageController = PageController(initialPage: 1);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              title: const Text(
                'Westminster',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: 33,
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListView.builder(
                          itemCount: chapters[index].v!,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: LinkifyText(
                                "${chapters[index].t}",
                                linkStyle: const TextStyle(color: Colors.red),
                                linkTypes: const [LinkType.hashTag],
                                onTap: (link) {
                                  debugPrint(link.value!.toString());
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
                // child: PageView.builder(
                //   itemCount: 33,
                //   controller: pageController,
                //   scrollDirection: Axis.horizontal,
                //   pageSnapping: true,
                //   itemBuilder: (BuildContext context, int index) {
                //     // bool plain = false;

                //     // String result = (plain == true)
                //     //     ? "${chapters[index].t}".replaceAll(RegExp(r'#\d+'), '')
                //     //     : "${chapters[index].t}";

                //     return ListView.builder(
                //       itemBuilder: (BuildContext context, int index) {

                //         return ListTile(
                //           title: LinkifyText(
                //             "${chapters[index].t}",
                //             linkStyle: const TextStyle(color: Colors.red),
                //             linkTypes: const [LinkType.hashTag],
                //             onTap: (link) {
                //               debugPrint(link.value!.toString());
                //             },
                //           ),
                //         );
                //       },
                //     );
                //   },
                // ),
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
