import 'package:flutter/material.dart';

class OrBarDivider extends StatelessWidget {
  final String barText;
  const OrBarDivider({required this.barText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const Divider(
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 0,
            color: Colors.black,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Or Sign In With'),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const Divider(
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
