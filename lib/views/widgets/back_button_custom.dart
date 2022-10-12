import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  VoidCallback onBack;
  BackButtonCustom({required this.onBack, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onBack,
      icon: const CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 100,
        child: Padding(
          padding: EdgeInsets.only(left: 6),
          child: Icon(
            Icons.arrow_back_ios,
            // color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
