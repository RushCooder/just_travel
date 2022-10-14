import 'package:flutter/material.dart';
import 'package:just_travel/views/pages/home-page/components/drawer/drawer-components/Drawer_body.dart';
import 'package:just_travel/views/pages/home-page/components/drawer/drawer-components/drawer_email_verify.dart';
import 'package:just_travel/views/pages/home-page/components/drawer/drawer-components/drawer_head.dart';
import 'package:just_travel/views/pages/home-page/components/drawer/drawer-components/sign_out_button.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.2),
            child: Column(
              children: const [
                DrawerHead(),
                DrawerBody(),
              ],
            ),
          ),
          const DrawerEmailVerify(),
          const SignOutButton(),
        ],
      ),
    );
  }
}
