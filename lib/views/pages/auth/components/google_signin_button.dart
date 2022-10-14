import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () async {
          try {
            showLoadingDialog(context);

            await context.read<AuthProvider>().signInWithGoogle();

            Navigator.pushNamedAndRemoveUntil(context,
                LauncherPage.routeName, (route) => false);
          } catch (error) {
            context
                .read<AuthProvider>()
                .setError(error.toString());
            Navigator.pop(context);
          }
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'images/google_icon.png',
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
