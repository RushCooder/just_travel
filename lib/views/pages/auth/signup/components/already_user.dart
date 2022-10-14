import 'package:flutter/material.dart';

class AlreadyUser extends StatelessWidget {
  const AlreadyUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('SIGN IN'),
        ),
      ],
    );
  }
}
