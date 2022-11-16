import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/hotel_provider.dart';

userImagePickerDialog(BuildContext context, {int index = -1}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Upload Image'),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showLoadingDialog(context);
                Provider.of<UserProvider>(context, listen: false)
                    .userPickImage(true)
                    .then(
                      (value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.camera,
                    size: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Camera'),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showLoadingDialog(context);
                Provider.of<UserProvider>(context, listen: false)
                    .userPickImage(false)
                    .then(
                      (value)  {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.image,
                    size: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Gallery'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
