import 'package:flutter/material.dart';
import 'package:just_travel/views/pages/auth/signup/signup_page.dart';

class NewUserOption extends StatelessWidget {
  const NewUserOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('New User?'),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, SignUpPage.routeName);
          },
          child: const Text('SIGN UP'),
        ),
      ],
    );
  }
}
