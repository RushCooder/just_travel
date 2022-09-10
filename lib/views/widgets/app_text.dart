import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String title;
  bool isTitle;
  double fontSize;
  Color color;

  AppText({
    required this.title,
    this.fontSize = 20,
    this.isTitle = true,
    this.color = Colors.black87,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: isTitle ? color : Colors.grey,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
