import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasuhisab/app/constants/Strings.dart';

electricityBox(BuildContext context,
    {required String title,
    required String message,
    required VoidCallback updatecall,
    required VoidCallback deletecall}) {
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
            TextButton(onPressed: deletecall, child: Text(delete.tr)),
            TextButton(onPressed: updatecall, child: Text(update.tr)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Ok')),
          ],
        );
      });
}
