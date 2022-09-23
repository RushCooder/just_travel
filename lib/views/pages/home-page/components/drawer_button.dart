import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Center(
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.withOpacity(0.3),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Icon(
                Icons.menu,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
