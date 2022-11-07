import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:just_travel/models/db-models/payment_model.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/models/db-models/user_model.dart';
import 'package:just_travel/providers/join_trip_provider.dart';
import 'package:just_travel/providers/payment_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/utils/payment_methods.dart';
import 'package:just_travel/views/pages/confirm-page/components/booking_details_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_method_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_now_button.dart';
import 'package:just_travel/views/pages/confirm-page/components/payment_summary_card.dart';
import 'package:just_travel/views/pages/confirm-page/components/title_text.dart';
import 'package:just_travel/views/pages/confirm-page/dialog/payment_number_dialog.dart';
import 'package:just_travel/views/pages/error-page/error_page.dart';
import 'package:just_travel/views/pages/success-page/success_page.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

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
            // const TitleText(title: 'Payment Method'),
            // const PaymentMethodCard(),

            // payment now button
            PaymentNowButton(
              onPressed: () async {
                try {
                  final paymentMethods = PaymentMethods();
                  UserModel user = context.read<UserProvider>().user!;

                  if (user.email?.isVerified == false) {
                    showMsg(context, 'Please verify your email');
                  } else {
                    String? phoneNumber = await paymentNumberDialog(context);

                    if (phoneNumber != null) {
                      SSLCTransactionInfoModel? sslModel =
                          await paymentMethods.sslCommerzGeneralCall(
                        phoneNumber: phoneNumber,
                        amount: context
                            .read<JoinTripProvider>()
                            .totalCost!
                            .toDouble(),
                        user: user,
                      );

                      if (sslModel != null) {
                        PaymentModel paymentModel = PaymentModel(
                          tripId: trip.id,
                          userId: user.id,
                          mobileNumber: phoneNumber,
                          tranId: sslModel.tranId,
                          amount: num.parse(sslModel.amount!),
                          status: sslModel.status,
                        );

                        // bool isPaid = await context
                        //     .read<PaymentProvider>()
                        //     .makePayment(paymentModel);
                        // if (!isPaid) throw Error();

                        context
                            .read<JoinTripProvider>()
                            .joinTrip(
                              trip: trip,
                              room: room,
                              user: user,
                              numberOfTravellers: numberOfTravellers,
                              paymentModel: paymentModel,
                            )
                            .then((value) {
                          context.read<TripProvider>().reset();
                          context.read<JoinTripProvider>().reset();
                          showMsg(context, 'Success');
                          Navigator.pushNamed(context, SuccessPage.routeName);
                        }).onError((error, stackTrace) {
                          context.read<TripProvider>().reset();
                          context.read<JoinTripProvider>().reset();
                          showMsg(context, 'Joining failed');
                          Navigator.pushNamed(context, ErrorPage.routeName);
                        });
                      }
                    }
                  }
                } catch (error) {
                  debugPrint('payment error: $error');
                }

                // UserModel user = context.read<UserProvider>().user!;
                //
                // if (user.email?.isVerified == false) {
                //   showMsg(context, 'Please verify your email');
                // } else {
                //   context
                //       .read<JoinTripProvider>()
                //       .joinTrip(trip, room, user, numberOfTravellers)
                //       .then((value) {
                //     context.read<TripProvider>().reset();
                //     context.read<JoinTripProvider>().reset();
                //     showMsg(context, 'Success');
                //     Navigator.pushNamed(context, SuccessPage.routeName);
                //   }).onError((error, stackTrace) {
                //     context.read<TripProvider>().reset();
                //     context.read<JoinTripProvider>().reset();
                //     showMsg(context, 'Joining failed');
                //     Navigator.pushNamed(context, ErrorPage.routeName);
                //   });
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
