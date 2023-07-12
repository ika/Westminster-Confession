import 'package:flutter/material.dart';
import 'package:westminster_confession/utils/utilities.dart';

// Bookmarks Dialog

String note = "";

class BMDialog {
  Future showBmDialog(context, arr) async {
    String txt = arr[1].toString();

    reduceLength(txt, 35);

    TextEditingController controller = TextEditingController();
    note = controller.text = txt;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bookmark?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  arr[0].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autofocus: true,
                      maxLength: 50,
                      controller: controller,
                      decoration: const InputDecoration(
                          labelText: 'Add your own text',
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                      onChanged: (value) {
                        note = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('YES', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('NO', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
