import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DrawerHead extends StatelessWidget {
  const DrawerHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) =>
          UserAccountsDrawerHeader(
            accountName: Text(
              userProvider.user!.name!,
              style: Theme.of(context).textTheme.headline5,
            ),
            accountEmail: Text(
              userProvider.user!.email!.emailId!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
    );
  }
}
