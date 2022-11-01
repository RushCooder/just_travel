import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/models/db-models/user_model.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/auth/signup/components/dialog/verification_dialog.dart';
import 'package:just_travel/views/pages/confirm-page/components/booking_details_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_method_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_now_button.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_summary_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/title_text.dart';
import 'package:just_travel/views/pages/error-page/error_page.dart';
import 'package:just_travel/views/pages/success-page/success_page.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class ConfirmPage extends StatelessWidget {
  static const routeName = '/home/trip-details-page/confirm-page';
  TripModel trip;
  RoomModel room;
  num numberOfTravellers;

  ConfirmPage(
      {required this.trip,
      required this.room,
      required this.numberOfTravellers,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            //booking details
            const TitleText(title: 'Booking Details'),
            BookingDetailsCard(trip: trip, room: room),
            const SizedBox(
              height: 10,
            ),

            //  payment summary
            const TitleText(title: 'Payment Summary'),
            PaymentSummaryCard(
                trip: trip, room: room, numberOfTravellers: numberOfTravellers),
            const SizedBox(
              height: 10,
            ),

            // payment methods
            const TitleText(title: 'Payment Method'),
            const PaymentMethodCard(),

            // payment now button
            PaymentNowButton(
              onPressed: () {
                UserModel user = context.read<UserProvider>().user!;

                if (user.email?.isVerified == false) {
                  showMsg(context, 'Please verify your email');
                } else {
                  context
                      .read<TripProvider>()
                      .joinTrip(trip, room, user, numberOfTravellers)
                      .then((value) {
                    context.read<TripProvider>().reset();
                    showMsg(context, 'Success');
                    Navigator.pushNamed(context, SuccessPage.routeName);
                  }).onError((error, stackTrace) {
                    context.read<TripProvider>().reset();
                    showMsg(context, 'Joining failed');
                    Navigator.pushNamed(context, ErrorPage.routeName);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
