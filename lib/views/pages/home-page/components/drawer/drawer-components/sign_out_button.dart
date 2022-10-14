import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:provider/provider.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          shape: const StadiumBorder(),
        ),
        onPressed: () {
          context.read<AuthProvider>().signOut().then(
                (value) => Navigator.pushNamedAndRemoveUntil(
                    context, LauncherPage.routeName, (route) => false),
              );
        },
        child: const Text('Sign Out'),
      ),
    );
  }
}
