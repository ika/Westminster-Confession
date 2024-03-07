import 'package:flutter/material.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/bkmarks/queries.dart';
import 'package:westminster_confession/utils/globals.dart';

BMQueries bmQueries = BMQueries();

const snackBarSaved = SnackBar(
  content: Text('BookMark Saved!'),
);

const snackBarExists = SnackBar(
  content: Text('BookMark already Exists!'),
);

Future<dynamic> showPopupMenu(BuildContext context, BMModel model) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height * .3;

  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(width, height, 50, 0),
    items: [
      PopupMenuItem(
        child: const Text("Bookmark"),
        onTap: () {
          bmQueries.getBookMarkExists(model.para).then((value) {
            (value < 1)
                ? bmQueries.saveBookMark(model).then((value) {
                    Future.delayed(
                        Duration(microseconds: Globals.navigatorDelay), () {
                      ScaffoldMessenger.of(context).showSnackBar(snackBarSaved);
                    });
                  })
                : ScaffoldMessenger.of(context).showSnackBar(snackBarExists);
          });
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
