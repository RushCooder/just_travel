import 'package:flutter/material.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/views/pages/trip-details-page/dialog/show_rooms_dialog.dart';
import 'package:provider/provider.dart';

class CheckUserTrip extends StatelessWidget {
  Widget onTrue;
  CheckUserTrip({required this.onTrue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tripProvider = context.read<TripProvider>();
    final userProvider = context.read<UserProvider>();
    return FutureBuilder(
      future: tripProvider.getTripByUserIdTripId(
          userProvider.user!.id!, tripProvider.tripModel!.id!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return onTrue;
        }

        if (snapshot.hasData) {
          return snapshot.data == true
              ? const Center(
                  child: Text('You have Joined this trip'),
                )
              : onTrue;
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
