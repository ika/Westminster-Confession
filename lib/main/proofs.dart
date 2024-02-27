import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/bloc/bloc_refs.dart';
import 'package:westminster_confession/main/model.dart';
import 'package:westminster_confession/main/queries.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:westminster_confession/utils/globals.dart';

late bool refsAreOn;

class ProofsPage extends StatefulWidget {
  const ProofsPage({super.key, required this.page});

  final int page;

  @override
  State<ProofsPage> createState() => _ProofsPageState();
}

class _ProofsPageState extends State<ProofsPage> {
  @override
  void initState() {
    super.initState();
    refsAreOn = context.read<RefsBloc>().state;
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        PageController(initialPage: widget.page);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          actions: [
            Switch(
              value: refsAreOn,
              onChanged: (bool value) {
                context.read<RefsBloc>().add(ChangeRefs(value));
                setState(() {
                  refsAreOn = value;
                });
              },
            ),
          ],
          title: const Text(
            'Westminster',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              Future.delayed(Duration(microseconds: Globals.navigatorDelay),
                  () {
                Navigator.of(context).pop();
              });
            },
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
                future: WeQueries().getChapter(index + 1),
                initialData: const [],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final chapter = snapshot.data![index];
                        if (refsAreOn) {
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
                        } else {
                          String result =
                              "${chapter.t}".replaceAll(RegExp(r"#\d+"), "");
                          return ListTile(
                            title: Text(result),
                          );
                        }
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
