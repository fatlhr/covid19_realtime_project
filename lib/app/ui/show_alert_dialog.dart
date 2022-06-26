import 'package:flutter/material.dart';

Future<void> showAlertDialog(
  BuildContext context,
  String title,
  String dialogMessage,
) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(dialogMessage),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}