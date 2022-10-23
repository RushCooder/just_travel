import 'package:flutter/material.dart';
import 'package:just_travel/providers/message_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/pages/inbox-page/inbox_page.dart';
import 'package:just_travel/views/pages/my-trips-page/my_trips_page.dart';
import 'package:just_travel/views/pages/profile-page/profile_page.dart';
import 'package:provider/provider.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, ProfilePage.routeName);
          },
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          onTap: () {
            context.read<TripProvider>().getTripByUserId(
                context.read<UserProvider>().user!.id!
            );
            Navigator.pushNamed(context, MyTripsPage.routeName);
          },
          leading: const Icon(Icons.card_travel),
          title: const Text('My Trips'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          onTap: () {
            context.read<MessageProvider>().getMessageGroupsByUserId(
                context.read<UserProvider>().user!.id!
            );
            Navigator.pushNamed(context, InboxPage.routeName);
          },
          leading: const Icon(Icons.message),
          title: const Text('Inbox'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
