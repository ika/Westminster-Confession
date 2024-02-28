import 'package:flutter/material.dart';

class GetRef {
  Future<dynamic> refDialog(BuildContext context, data) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data['header']),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(data['contents']),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
