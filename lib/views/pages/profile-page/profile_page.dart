import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/views/pages/profile-page/components/user_details_row.dart';
import 'package:just_travel/views/widgets/profile_circular_image.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // profile image, name, and email section
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  userProvider.user!.profileImage == null
                      ? CircleAvatar(
                          radius: 30,
                          child: Text(
                            context
                                .read<UserProvider>()
                                .user!
                                .name!
                                .substring(0, 2),
                          ),
                        )
                      : ProfileCircularImage(
                          radius: 70,
                          width: 150,
                          height: 150,
                          image:
                              '${baseUrl}uploads/${userProvider.user!.profileImage}',
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<UserProvider>(
                    builder: (context, provider, child) => Text(
                      provider.user!.name!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white60,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<UserProvider>(
                    builder: (context, provider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.user!.email!.emailId!,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white60,
                                  ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.verified,
                          size: 20,
                          color: provider.user?.email?.isVerified == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // other profile details
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Details',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // mobile number
          UserDetailsRow(
            fieldName: 'Mobile Number: ',
            value: userProvider.user!.mobile!.number ?? 'No number added',
          ),
          // city
          UserDetailsRow(
            fieldName: 'Current City: ',
            value: userProvider.user!.city ?? 'No number added',
          ),
          // division
          UserDetailsRow(
            fieldName: 'Current Division: ',
            value: userProvider.user!.division ?? 'No number added',
          ),
        ],
      ),
    );
  }
}
