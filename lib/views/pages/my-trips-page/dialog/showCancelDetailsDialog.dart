import 'package:flutter/material.dart';

Future<bool?> showCancelDetailsDialog(BuildContext context) async{
  return showDialog<bool>(
    context: context,
    // false = user must tap button, true = tap outside dialog
    builder: (context) {
      return AlertDialog(
        title: const Text('Notify'),
        content: const Text('Your trip has been canceled. Please check your email for more details'),
        actions: [
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