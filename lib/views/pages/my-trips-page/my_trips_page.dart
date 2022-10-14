import 'package:flutter/material.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/my-trips-page/components/trip_list_card.dart';
import 'package:just_travel/views/widgets/back_button_custom.dart';
import 'package:provider/provider.dart';

class MyTripsPage extends StatelessWidget {
  static const routeName = '/my-trips';

  MyTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // app bar
            Row(
              children: [
                BackButtonCustom(
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'My Trips',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),

            Consumer<TripProvider>(
              builder: (context, provider, child) {
                final myTripList = provider.myTripsList;

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myTripList.length,
                  itemBuilder: (context, index) =>
                      TripListCard(trip: myTripList[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
