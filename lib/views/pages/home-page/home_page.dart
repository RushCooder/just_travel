import 'package:flutter/material.dart';
import 'package:just_travel/utils/theme/status_bar_theme.dart';
import 'package:just_travel/views/pages/home-page/components/app_bar_trailing.dart';
import 'package:just_travel/views/pages/home-page/components/drawer_button.dart';
import 'package:just_travel/views/screens/home_screen/components/upcoming_trip.dart';
import 'package:just_travel/views/widgets/appbar_layout.dart';
import '../../widgets/app_text.dart';
import 'components/custom_app_bar.dart';
import 'components/search_bar.dart';
import 'components/drawer/user_drawer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<UserProvider>().fetchUserByEmail(AuthService.user!.email!);

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
            const AppBarTrailing(),
          ]),
      body: SafeArea(
        child: ListView(
          children: [
            //Appbar
            // const CustomAppBar(),
            // const SizedBox(
            //   height: 15,
            // ),
            //Search options
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
