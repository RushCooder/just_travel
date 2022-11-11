import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/profile-page/components/p_widget.dart';
import 'package:just_travel/views/widgets/profile_circular_image.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/urls.dart';
import '../../widgets/dialogs/user_image_picker_dialog.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // profile pic, name, email, verified section
                  Row(
                    children: [
                      Stack(
                        children: [
                          userProvider.user!.profileImage == null
                              ? CircleAvatar(
                                  radius: 50,
                                  child: Text(
                                    context
                                        .read<UserProvider>()
                                        .user!
                                        .name!
                                        .substring(0, 2),
                                  ),
                                )
                              : ProfileCircularImage(
                                  radius: 55,
                                  width: 150,
                                  height: 150,
                                  image:
                                      '${baseUrl}uploads/${userProvider.user!.profileImage}',
                                ),
                          Positioned(
                            bottom: 0,
                            right: 15,
                            child: GestureDetector(
                              onTap: () async {
                                try{
                                  await userImagePickerDialog(context);
                                  await userProvider.updateUser({
                                    'profileImage' : userProvider.userImagePath
                                  }, userProvider.user!.id!);
                                }
                                catch(error){
                                  debugPrint('update profile pic error: $error');
                                  showMsg(context, 'Image uploading failed');
                                }

                              },
                              child: Container(
                                height: 33,
                                width: 33,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // user name
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                child: Text(
                                  '${userProvider.user!.name}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          // email
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                child: Text(
                                  '${userProvider.user!.email!.emailId}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // verified status section
                          Row(
                            children: [
                              const Text('Verified'),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.verified,
                                size: 15,
                                color:
                                    userProvider.user?.email?.isVerified == true
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  ProfileCustomWidgets(
                    title: 'About',
                    info:
                        userProvider.user!.about ?? 'Write something about you',
                    updateKey: 'about',
                  ),
                  const SizedBox(height: 5),
                  ProfileCustomWidgets(
                    title: 'Mobile Number',
                    info: userProvider.user!.mobile!.number ??
                        'Add mobile number',
                    updateKey: 'mobile',
                  ),
                  const SizedBox(height: 5),
                  ProfileCustomWidgets(
                    title: 'Gender',
                    info: userProvider.user!.gender != null
                        ? userProvider.user!.gender![0].toUpperCase() +
                            userProvider.user!.gender!
                                .substring(1)
                                .toLowerCase()
                        : 'Select gender',
                    updateKey: 'gender',
                  ),
                  const SizedBox(height: 5),
                  ProfileCustomWidgets(
                    title: 'Date of Birth',
                    info: userProvider.user!.dob != null
                        ? getFormattedDateTime(
                            dateTime: userProvider.user!.dob!,
                            pattern: 'MMM dd yyyy')
                        : 'Add your date of birth',
                    updateKey: 'dob',
                  ),
                  const SizedBox(height: 5),
                  ProfileCustomWidgets(
                    title: 'Address',
                    info:
                        '${userProvider.user!.district}, ${userProvider.user!.division}',
                    updateKey: 'address',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
