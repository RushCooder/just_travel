import 'package:flutter/material.dart';
import 'package:just_travel/providers/join_trip_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/my-trips-page/components/empty_list.dart';
import 'package:just_travel/views/pages/my-trips-page/dialog/showCancelDetailsDialog.dart';
import 'package:just_travel/views/pages/my-trips-page/dialog/showCancelTripDialog.dart';
import 'package:just_travel/views/pages/trip-details-page/trip_details_page.dart';
import 'package:just_travel/views/widgets/trip_list_card.dart';
import 'package:provider/provider.dart';

class MyTripsPage extends StatelessWidget {
  static const routeName = '/my-trips';

  MyTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // app bar
            // Row(
            //   children: [
            //     BackButtonCustom(
            //       onBack: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //     Text(
            //       'My Trips',
            //       style: Theme.of(context).textTheme.headline6,
            //     ),
            //   ],
            // ),

            Consumer<TripProvider>(
              builder: (context, provider, child) {
                final myTripList = provider.myTripsList;

                return myTripList.isEmpty
                    ? const EmptyList()
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myTripList.length,
                        itemBuilder: (context, index) => TripListCard(
                          trip: myTripList[index],
                          isMyTrip: true,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, TripDetailsPage.routeName,
                                arguments: myTripList[index].id);
                          },
                          onLongPress: () async {

                            try{
                              final joinTripProvider = context.read<JoinTripProvider>();
                              final userProvider = context.read<UserProvider>();
                              bool isOk = (await showCancelTripDialog(context)) ?? false;
                              if (isOk){
                               bool isCanceled = await joinTripProvider.cancelTrip(userProvider.user!.id!, provider.tripList[index].id!);

                               if (isCanceled){
                                 showCancelDetailsDialog(context);
                                 await provider.getTripByUserId(userProvider.user!.id!);

                               }


                              }
                            }catch(error){
                              debugPrint('error canceling trip: $error');
                              showMsg(context, 'Failed to canceled');
                            }



                          },
                        ),

                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
