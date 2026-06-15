import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westminster_confession/bloc/bloc_font.dart';
import 'package:westminster_confession/bloc/bloc_italic.dart';
import 'package:westminster_confession/bloc/bloc_size.dart';
import 'package:westminster_confession/fonts/list.dart';
import 'package:westminster_confession/utils/globals.dart';

class FontsPage extends StatefulWidget {
  const FontsPage({super.key});

  @override
  State<FontsPage> createState() => _FontsPageState();
}

class _FontsPageState extends State<FontsPage> {
  late int selectedFont;
  late int fontNumber;
  late bool italicIsOn;
  late double textSize;
  // late bool themeIsDark;

  @override
  void initState() {
    super.initState();
    selectedFont = context.read<FontBloc>().state;
    italicIsOn = context.read<ItalicBloc>().state;
    textSize = context.read<SizeBloc>().state;
    //themeIsDark = context.read<ThemeBloc>().state;
  }

  void changeFontSize() {
    double tempSize = textSize;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Adjust Font Size"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (tempSize > 12) setState(() => tempSize -= 2);
                    },
                  ),
                  Text(
                    tempSize.toInt().toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (tempSize < 32) setState(() => tempSize += 2);
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<SizeBloc>().add(UpdateSize(size: tempSize));
                setState(() => textSize = tempSize);
                Navigator.pop(context);
              },
              child: const Text("OK", style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> fontConfirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(fontsList[fontNumber]),
          content: Text(
            "The Lord is my shepherd, I lack nothing. He makes me lie down in green pastures, he leads me beside quiet waters, he refreshes my soul. He guides me along the right paths for his name’s sake. Even though I walk through the darkest valley, I will fear no evil, for you are with me; your rod and your staff, they comfort me. You prepare a table before me in the presence of my enemies. You anoint my head with oil; my cup overflows. Surely your goodness and mercy will follow me all the days of my life, and I will dwell in the house of the Lord forever.",
            softWrap: true,
            style: TextStyle(
              fontFamily: fontsList[fontNumber],
              fontStyle: (italicIsOn) ? FontStyle.italic : FontStyle.normal,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FontBloc>().add(
                        UpdateFont(font: fontNumber),
                      );
                      Future.delayed(
                        Duration(milliseconds: Globals.navigatorDelay),
                        () {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                          setState(() {
                            selectedFont = fontNumber;
                          });
                        },
                      );
                    },
                    child: const Text("Select"),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
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
          ),
          leading: GestureDetector(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Future.delayed(
                  Duration(milliseconds: Globals.navigatorDelay),
                  () {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
          ),
          //elevation: 16,
          title: Text(
            "Font size $textSize",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          // actions: [
          // PopupMenuButton(
          //   icon: const Icon(Icons.format_size_sharp),
          //   itemBuilder: (context) {
          //     if (Platform.isLinux || Platform.isWindows) {
          //       return [
          //         const PopupMenuItem<int>(value: 14, child: Text("14.0")),
          //         const PopupMenuItem<int>(value: 16, child: Text("16.0")),
          //         const PopupMenuItem<int>(value: 18, child: Text("18.0")),
          //         const PopupMenuItem<int>(value: 20, child: Text("20.0")),
          //         const PopupMenuItem<int>(value: 22, child: Text("22.0")),
          //         const PopupMenuItem<int>(value: 24, child: Text("24.0")),
          //         const PopupMenuItem<int>(value: 26, child: Text("26.0")),
          //         const PopupMenuItem<int>(value: 28, child: Text("28.0")),
          //         const PopupMenuItem<int>(value: 30, child: Text("30.0")),
          //       ];
          //     } else {
          //       return [
          //         const PopupMenuItem<int>(value: 12, child: Text("12.0")),
          //         const PopupMenuItem<int>(value: 14, child: Text("14.0")),
          //         const PopupMenuItem<int>(value: 16, child: Text("16.0")),
          //         const PopupMenuItem<int>(value: 18, child: Text("18.0")),
          //         const PopupMenuItem<int>(value: 20, child: Text("20.0")),
          //         const PopupMenuItem<int>(value: 22, child: Text("22.0")),
          //         const PopupMenuItem<int>(value: 24, child: Text("24.0")),
          //       ];
          //     }
          //   },
          //   onSelected: (int value) {
          //     double val = value.toDouble();
          //     context.read<SizeBloc>().add(UpdateSize(size: val));
          //     setState(() {
          //       textSize = val;
          //     });
          //   },
          // ),
          // PopupMenuButton(
          //   icon: const Icon(Icons.format_italic_sharp),
          //   itemBuilder: (context) {
          //     return [
          //       const PopupMenuItem<int>(value: 0, child: Text("Normal")),
          //       const PopupMenuItem<int>(
          //         value: 1,
          //         child: Text(
          //           "Italic",
          //           style: TextStyle(fontStyle: FontStyle.italic),
          //         ),
          //       ),
          //     ];
          //   },
          //   onSelected: (int value) {
          //     bool on = (value == 1) ? true : false;
          //     context.read<ItalicBloc>().add(ChangeItalic(on));
          //     setState(() {
          //       italicIsOn = on;
          //     });
          //   },
          // ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 400,
              child: ListView.builder(
                itemCount: fontsList.length,
                itemBuilder: (BuildContext context, int index) {
                  String t = (italicIsOn) ? 'Italic' : 'Normal';
                  return ListTile(
                    title: Text(
                      "${fontsList[index]} $t",
                      style: TextStyle(
                        fontStyle: (italicIsOn)
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),
                    subtitle: Text(
                      "The Lord is my shepherd",
                      style: TextStyle(
                        backgroundColor: (index == selectedFont)
                            ? Theme.of(context).colorScheme.tertiaryContainer
                            : null,
                        fontStyle: (italicIsOn)
                            ? FontStyle.italic
                            : FontStyle.normal,
                        fontFamily: fontsList[index],
                        fontSize: textSize,
                      ),
                    ),
                    onTap: () {
                      fontNumber = index;
                      fontConfirmDialog(context);
                    },
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.extended(
              heroTag: "size",
              icon: const Icon(Icons.format_size),
              label: Text("${textSize.toInt()}"),
              onPressed: changeFontSize,
            ),
            const SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: "italic",
              icon: Icon(italicIsOn ? Icons.format_italic : Icons.text_fields),
              label: Text(italicIsOn ? "Italic" : "Normal"),
              onPressed: () {
                context.read<ItalicBloc>().add(ChangeItalic(!italicIsOn));
                setState(() => italicIsOn = !italicIsOn);
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
