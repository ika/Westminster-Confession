import 'package:flutter/material.dart';

// Alert

Future<void> showAlertDialog(context, data) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(data['header']),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(data['contents']),
            ],
          ),
        ),
        actions: <Widget>[
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