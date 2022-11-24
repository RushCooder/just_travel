import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/join_trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/trip-details-page/trip_details_page.dart';
import 'package:provider/provider.dart';

class TripListCard extends StatelessWidget {
  final TripModel trip;
  VoidCallback? onPressed;
  VoidCallback? onLongPress;
  bool isMyTrip;
  TripListCard({
    required this.trip,
    this.onPressed,
    this.onLongPress,
    this.isMyTrip = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              '${baseUrl}uploads/${trip.photos![0]}',
              height: 200,
              width: 100,
              fit: BoxFit.cover,
            ),
            title: Text(trip.placeName!),
            subtitle: Text(
              '${getFormattedDateTime(dateTime: trip.startDate!, pattern: 'MMM dd')} - ${getFormattedDateTime(dateTime: trip.endDate!, pattern: 'MMM dd, yyyy')}',
            ),
            trailing: isMyTrip
                ? SizedBox(
                    height: 50,
                    width: 70,
                    child: Center(
                      child: FutureBuilder(
                        future: context
                            .read<JoinTripProvider>()
                            .getJoinDetailsByUserAndTrip(
                                context.read<UserProvider>().user!.id!, trip.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text('${snapshot.data!.status}');
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
