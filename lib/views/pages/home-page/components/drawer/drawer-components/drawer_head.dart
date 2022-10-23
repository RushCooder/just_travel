import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/views/widgets/profile_circular_image.dart';
import 'package:provider/provider.dart';

class DrawerHead extends StatelessWidget {
  const DrawerHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return UserAccountsDrawerHeader(
          currentAccountPicture: userProvider.user!.profileImage == null
              ? CircleAvatar(
                  radius: 30,
                  child: Text(
                    userProvider.user!.name!.substring(0, 2),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white60,
                        ),
                  ),
                )
              : ProfileCircularImage(
                  radius: 70,
                  image: '${baseUrl}uploads/${userProvider.user!.profileImage}',
                ),
          accountName: Text(
            userProvider.user!.name!,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white60,
                  fontSize: 16,
                ),
          ),
          accountEmail: Text(
            userProvider.user!.email!.emailId!,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.white38,
                  fontSize: 14,
                ),
          ),
        );
      },
    );
  }
}
