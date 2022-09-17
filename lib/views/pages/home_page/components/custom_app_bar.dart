import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/services/auth/auth_service.dart';
import 'package:just_travel/views/pages/signin_page.dart';
import 'package:provider/provider.dart';

import '../../../pages/launcher_page.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Builder(
        builder:(context) =>  GestureDetector(
          onTap: () async {
            Scaffold.of(context).openDrawer();
            // await AuthService.reload;
            // print(AuthService.user);

             // context.read<AuthProvider>().signOut().then((value) {
             //   print('signout');
             //   Navigator.pushNamedAndRemoveUntil(context,
             //       LauncherPage.routeName, (route) => false);
             // });
            // await context.read<UserProvider>().fetchUserByEmail('tariqulislamkst9923@gmail.com');
            // print(context.read<UserProvider>().user);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.withOpacity(0.3),
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Center(
                child: Icon(
                  Icons.menu,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
      title: const Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: CircleAvatar(
        radius: 25,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'images/profile.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
