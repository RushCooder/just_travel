import 'package:flutter/material.dart';
import 'package:just_travel/views/pages/request-trip-page/add-request-page/dialog/show_hotels_dialog.dart';

class HotelButton extends StatelessWidget {
  const HotelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            showHotelsDialog(context: context);
          },
          child: const Text('Tap to select hotel'),
        ),
      ],
    );
  }
}
