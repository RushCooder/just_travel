import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/pages/home-page/components/app_bar_trailing.dart';
import 'package:just_travel/views/widgets/network_image_loader.dart';
import 'package:provider/provider.dart';

class ProfileCircularImage extends StatelessWidget {
  double radius, height, width;
  final String image;
  ProfileCircularImage(
      {required this.image,
      this.height = 50,
      this.width = 50,
      this.radius = 50,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return AppBarTrailing(
          radius: radius,
          child: NetworkImageLoader(
            image: image,
            width: width,
            height: height,
          ),
          // : Text(userProvider.user?.name![0] ?? 'PP'),
          // child: userProvider.user?.profileImage != null ? Image.network(
          //   '${baseUrl}uploads/${userProvider.user!.profileImage}',
          //   fit: BoxFit.cover,
          // ) : Image.asset(
          //   'images/img.png',
          //   fit: BoxFit.cover,
          // ),
        );
      },
    );
  }
}
