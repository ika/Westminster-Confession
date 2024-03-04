  
import 'package:flutter/material.dart';
import 'package:westminster_confession/main/model.dart';

Future<dynamic> showPopupMenu(BuildContext context, Wesminster chapter) async {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * .3;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(width, height, 50, 0),
      items: [
        PopupMenuItem(
          child: const Text("Bookmark"),
          onTap: () {
            debugPrint("${chapter.c} ${chapter.id}");
            // (!getBookMarksMatch(verseBid))
            //     ? insertBookMark(verseBid).then((value) {
            //         Future.delayed(
            //             Duration(milliseconds: Globals.navigatorLongDelay), () {
            //           ScaffoldMessenger.of(context)
            //               .showSnackBar(bookMarkSnackBar);
            //         });

            //         setState(() {});
            //       })
            //     : Future.delayed(
            //         Duration(milliseconds: Globals.navigatorDelay),
            //         () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => const BookMarksPage(),
            //             ),
            //           ).then((value) {
            //             //animationController.reverse();
            //             setState(() {});
            //           });
            //         },
            //       );
          },
        ),
        PopupMenuItem(
          child: const Text("Highlight"),
          onTap: () {
            //debugPrint(rowid.toString());
            // (!getHighLightMatch(verseBid))
            //     ? insertHighLight(verseBid).then((value) {
            //         Future.delayed(
            //             Duration(milliseconds: Globals.navigatorLongDelay), () {
            //           ScaffoldMessenger.of(context)
            //               .showSnackBar(hiLightAddedSnackBar);
            //         });

            //         setState(() {});
            //       })
            //     : Future.delayed(
            //         Duration(milliseconds: Globals.navigatorDelay),
            //         () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const HighLightsPage()),
            //           ).then((value) {
            //             setState(() {});
            //           });
            //         },
            //       );
          },
        ),
        // PopupMenuItem(
        //   child: const Text("Note"),
        //   onTap: () {
        //     (!getNotesMatch(verseBid))
        //         ? saveNote(verseBid).then((value) {
        //             Future.delayed(
        //                 Duration(milliseconds: Globals.navigatorLongDelay), () {
        //               ScaffoldMessenger.of(context)
        //                   .showSnackBar(noteAddedSnackBar);
        //             });
        //             setState(() {});
        //           })
        //         : Future.delayed(
        //             Duration(milliseconds: Globals.navigatorDelay),
        //             () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => const NotesPage(),
        //                 ),
        //               ).then((value) {
        //                 setState(() {});
        //               });
        //             },
        //           );
        //   },
        // ),
        PopupMenuItem(
          child: const Text("Copy"),
          onTap: () {
            //debugPrint(rowid.toString());
           // copyVerseWrapper(context);
          },
        ),
      ],
      elevation: 8.0,
    );
  }