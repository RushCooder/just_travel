import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:provider/provider.dart';

import 'item_tile.dart';

class BookingDetailsCard extends StatelessWidget {
  final TripModel trip;
  final RoomModel room;
  const BookingDetailsCard({required this.trip, required this.room, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ItemTile(
            title: trip.placeName!,
            subTitle: 'Package',
            cost: trip.cost!,
            icon: Icons.location_city,
          ),
          FutureBuilder(
            future: context.read<HotelProvider>().getHotelById(trip.hotel!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ItemTile(
                  title: '${snapshot.data!.name} (${room.title})',
                  subTitle: 'Hotel & Resort',
                  cost: trip.cost!,
                  icon: Icons.hotel,
                );
              }
              if (snapshot.hasError) {
                return const Text('Server error');
              }
              return const CircularProgressIndicator();
            },
          ),
          ItemTile(
            title: getFormattedDateTime(dateTime: trip.schedule!),
            subTitle: 'Date',
            cost: trip.cost!,
            icon: Icons.date_range,
          ),
        ],
      ),
    );
  }
}
