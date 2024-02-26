import 'package:flutter/material.dart';
import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/queries.dart';
import 'package:linkfy_text/linkfy_text.dart';

class ProofsPage extends StatefulWidget {
  const ProofsPage({super.key});

  @override
  State<ProofsPage> createState() => _ProofsPageState();
}

class _ProofsPageState extends State<ProofsPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: const Text(
            'Westminster',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          itemCount: 33,
          physics: const BouncingScrollPhysics(),
          pageSnapping: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Wesminster>>(
                future: WeQueries().getChapter(index +1),
                initialData: const [],
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final chapter = snapshot.data![index];
                            return ListTile(
                              title: LinkifyText(
                                "${chapter.t}",
                                linkStyle: const TextStyle(color: Colors.red),
                                linkTypes: const [LinkType.hashTag],
                                onTap: (link) {
                                  debugPrint(link.value!.toString());
                                },
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
