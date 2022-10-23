import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/utils/theme/status_bar_theme.dart';
import 'package:just_travel/views/pages/home-page/components/app_bar_trailing.dart';
import 'package:just_travel/views/pages/home-page/components/drawer_button.dart';
import 'package:just_travel/views/pages/profile-page/profile_page.dart';
import 'package:just_travel/views/screens/home_screen/components/upcoming_trip.dart';
import 'package:just_travel/views/widgets/appbar_layout.dart';
import 'package:just_travel/views/widgets/profile_circular_image.dart';
import 'package:provider/provider.dart';
import '../../../services/auth/auth_service.dart';
import '../../widgets/app_text.dart';
import 'components/custom_app_bar.dart';
import 'components/search_bar.dart';
import 'components/drawer/user_drawer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserProvider>().fetchUserByEmail(AuthService.user!.email!);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // TODO: Drawer will be added
      drawer: const UserDrawer(),
      appBar: appbarLayout(
        leading: const DrawerButton(),
        title: 'Home',
        iconTheme: Theme.of(context).iconTheme,
        textStyle: Theme.of(context).textTheme.headline6,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfilePage.routeName);
            },
            child: context.read<UserProvider>().user!.profileImage == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      child: Text(
                        context
                            .read<UserProvider>()
                            .user!
                            .name!
                            .substring(0, 2),
                      ),
                    ),
                  )
                : ProfileCircularImage(
                    radius: 30,
                    image:
                        '${baseUrl}uploads/${context.read<UserProvider>().user!.profileImage}',
                  ),
          ),

          // ProfileCircularImage(
          //   image: '${baseUrl}uploads/${context.read<UserProvider>().user!.profileImage}',
          // ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            //Appbar
            // const CustomAppBar(),
            // const SizedBox(
            //   height: 15,
            // ),
            //Search options
            const SizedBox(
              height: 30,
            ),
            const SearchBar(),

            const SizedBox(
              height: 20,
            ),
            //popular trip text
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   child: AppText(
            //     title: 'Popular Trip',
            //   ),
            // ),
            //popular trip cards horizontal listview in a container
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 230,
            //   margin: const EdgeInsets.all(10),
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: tripPackages.length,
            //     itemBuilder: (context, index) => TravelCard(
            //       title: tripPackages[index].title,
            //       location: tripPackages[index].location,
            //       image: tripPackages[index].images[0],
            //       availableDate: tripPackages[index].availableDate,
            //     ),
            //   ),
            // ),

            //upcoming trip text
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AppText(
                title: 'Upcoming Trip',
              ),
            ),

            const SizedBox(
              height: 7,
            ),
            const UpComingTrip(),
          ],
        ),
      ),
    );
  }
}
