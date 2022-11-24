import 'package:flutter/material.dart';

Future<bool?> showCancelTripDialog(BuildContext context) async{
  return showDialog<bool>(
    context: context,
    // false = user must tap button, true = tap outside dialog
    builder: (context) {
      return AlertDialog(
        title: const Text('Cancel'),
        content: const Text('Do you want to cancel this trip?'),
        actions: [
          TextButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: const Text('YES'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}