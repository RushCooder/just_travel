import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/trip-details-page/trip_details_page.dart';

class TripListCard extends StatelessWidget {
  final TripModel trip;
  VoidCallback? onPressed;
  TripListCard({required this.trip, this.onPressed,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
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
              getFormattedDateTime(dateTime: trip.startDate!),
            ),
          ),
        ),
      ),
    );
  }
}
