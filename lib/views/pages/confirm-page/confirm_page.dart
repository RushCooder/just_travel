import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/models/db-models/user_model.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/confirm-page/components/booking_details_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_method_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_now_button.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_summary_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/title_text.dart';
import 'package:just_travel/views/widgets/back_button_custom.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class ConfirmPage extends StatelessWidget {
  static const routeName = '/home/trip-details-page/confirm-page';
  TripModel trip;
  RoomModel room;

  ConfirmPage({required this.trip, required this.room, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                BackButtonCustom(
                  onBack: () {
                    context.read<TripProvider>().costCalculate(trip, room);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            //booking details
            const TitleText(title: 'Booking Details'),
            BookingDetailsCard(trip: trip, room: room),
            const SizedBox(
              height: 10,
            ),

            //  payment summary
            const TitleText(title: 'Payment Summary'),
            PaymentSummaryCard(trip: trip, room: room),
            const SizedBox(
              height: 10,
            ),

            // payment methods
            const TitleText(title: 'Payment Method'),
            const PaymentMethodCard(),

            // payment now button
            PaymentNowButton(
              onPressed: () {
                showLoadingDialog(context);
                UserModel user = context.read<UserProvider>().user!;
                context
                    .read<TripProvider>()
                    .joinTrip(trip, room, user)
                    .then((value) {
                  context.read<TripProvider>().resetValue();
                  showMsg(context, 'Success');
                  int count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 3;
                  });
                }).onError((error, stackTrace) {
                  context.read<TripProvider>().resetValue();
                  showMsg(context, 'Joining failed');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
