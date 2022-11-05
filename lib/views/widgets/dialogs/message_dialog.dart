import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> messageDialog(BuildContext context, String message) {
 return showDialog<Future<void>>(
    context: context,
    // barrierDismissible: barrierDismissible,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Message'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              return;
            },
          ),
        ],
      );
    },
  );
}
