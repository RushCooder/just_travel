import 'package:flutter/material.dart';

class DefaultErrorPage extends StatelessWidget {
  const DefaultErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Error page'),
      ),
    );
  }
}
