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

Future<dynamic> showPopupMenu(BuildContext context, BmModel model) async {
  
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height * .3;

  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(width, height, 50, 0),
    items: [
      PopupMenuItem(
        child: const Text("Bookmark"),
        onTap: () {
          bmQueries.getBookMarkExists(model.doc, model.page, model.para).then(
            (value) {
              (value < 1)
                  ? bmQueries.saveBookMark(model).then((value) {
                      Future.delayed(
                          Duration(microseconds: Globals.navigatorDelay), () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarSaved);
                      });
                    })
                  : ScaffoldMessenger.of(context).showSnackBar(snackBarExists);
            },
          );
        },
      ),
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
