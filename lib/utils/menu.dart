import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:westminster_confession/bkmarks/model.dart';
import 'package:westminster_confession/bkmarks/queries.dart';
import 'package:westminster_confession/utils/globals.dart';
import 'package:westminster_confession/utils/utils.dart';

BMQueries bmQueries = BMQueries();

const snackBarSaved = SnackBar(
  content: Text('BookMark Saved!'),
);

const snackBarExists = SnackBar(
  content: Text('BookMark already Exists!'),
);

const textCopiedSnackBar = SnackBar(
  content: Text('Text Copied'),
);

Future<dynamic> showPopupMenu(BuildContext context, BmModel model) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height * .3;

  model.subtitle = prepareText(model.subtitle, 150);

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
          final copyText = <String>[model.title, model.subtitle];

          final sb = StringBuffer();
          sb.writeAll(copyText);

          Clipboard.setData(
            ClipboardData(text: sb.toString()),
          ).then((_) {
            Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay),
                () {
              ScaffoldMessenger.of(context).showSnackBar(textCopiedSnackBar);
            });
          });
        },
      ),
    ],
    elevation: 8.0,
  );
}
