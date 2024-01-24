import 'package:flutter/material.dart';

dialogBox(BuildContext context,
    {required String title, required String message, required String btnname}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(btnname)),
          ],
        );
      });
}
