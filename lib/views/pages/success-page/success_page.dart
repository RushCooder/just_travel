import 'package:flutter/material.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class SuccessPage extends StatelessWidget {
  static const routeName = '/home/trip-details-page/confirm-page/success-page';
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<TripProvider>().reset();
        context.read<RoomProvider>().reset();
        context.read<HotelProvider>().reset();
        int count = 0;
        Navigator.popUntil(context, (route) => count++ == 4);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Status'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Congratulations!',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 22,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('You have successfully joined this tour.'),
              const SizedBox(
                height: 3,
              ),
              const Text(
                  'We have sent you an email with more details about this trip'),
              const SizedBox(
                height: 5,
              ),
              const Text('Have a good day!'),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  context.read<TripProvider>().reset();
                  context.read<RoomProvider>().reset();
                  context.read<HotelProvider>().reset();

                  int count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 4;
                  });
                },
                child: const Text(
                  'CONTINUE BOOKING',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
