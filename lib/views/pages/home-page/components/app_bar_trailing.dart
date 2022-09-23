import 'package:flutter/material.dart';

class AppBarTrailing extends StatelessWidget {
  const AppBarTrailing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: CircleAvatar(
        radius: 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'images/profile.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
