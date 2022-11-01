import 'package:flutter/material.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class ErrorPage extends StatelessWidget {
  static const routeName = '/home/trip-details-page/confirm-page/error-page';
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Status'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cancel_outlined,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'OOPS!',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Something went wrong.'),
            const SizedBox(
              height: 3,
            ),
            const Text(
                'Go back and try again'),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'TRY AGAIN',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
