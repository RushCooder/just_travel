import 'package:flutter/material.dart';

class AppBarTrailing extends StatelessWidget {
  final Widget child;
  double radius;
  AppBarTrailing({required this.child, required this.radius,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: CircleAvatar(
        radius: radius,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(radius),
          child: child,
        ),
      ),
    );
  }
}
