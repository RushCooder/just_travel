import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/utils/helper_functions.dart';

class TripTitleCard extends StatelessWidget {
  final TripModel trip;
  const TripTitleCard({required this.trip, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip!.placeName!.toUpperCase(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red.shade700,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(trip.district!,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontSize: 14)),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scheduled',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.red.shade700,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        getFormattedDateTime(
                            dateTime: trip.startDate!, pattern: 'MMM dd, yyyy'),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
