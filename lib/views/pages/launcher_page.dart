import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/pages/auth/signin/signin_page.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import 'home-page/home_page.dart';

class LauncherPage extends StatefulWidget {
  static const routeName = '/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthProvider authProvider = context.read<AuthProvider>();

    UserProvider userProvider = context.read<UserProvider>();

    Future.delayed(
      Duration.zero,
      () {
        // Navigator.pushNamedAndRemoveUntil(
        //           context, HomePage.routeName, (route) => false);

        //TODO: fix routing and authentication
        print('launcher page is deciding');
        print('current user: ${authProvider.getCurrentUser()}');
        if (authProvider.getCurrentUser() != null) {
          try {
            userProvider
                .fetchUserByEmail(authProvider.getCurrentUser()!.email!);
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.routeName, (route) => false);
          } catch (error) {
            print('error at launcher page: $error');
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, SignInPage.routeName, (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
