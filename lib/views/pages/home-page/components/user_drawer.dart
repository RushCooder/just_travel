import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.brown,
      child: ListView(
        children: [
          DrawerHeader(
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    userProvider.user!.name!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    userProvider.user!.email!.emailId!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthProvider>().signOut().then(
                            (value) => Navigator.pushNamedAndRemoveUntil(
                                context,
                                LauncherPage.routeName,
                                (route) => false),
                          );
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
