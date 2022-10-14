import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/utils/theme/status_bar_theme.dart';
import 'package:just_travel/views/pages/confirm-page/confirm_page.dart';
import 'package:just_travel/views/pages/trip-details-page/components/cover_photo.dart';
import 'package:just_travel/views/pages/trip-details-page/components/hotel_list_tile.dart';
import 'package:just_travel/views/pages/trip-details-page/components/join_card.dart';
import 'package:just_travel/views/pages/trip-details-page/components/trip_title_card.dart';
import 'package:just_travel/views/widgets/appbar_layout.dart';
import 'package:just_travel/views/widgets/back_button_custom.dart';
import 'package:just_travel/views/widgets/check_user_trip.dart';
import 'package:just_travel/views/widgets/expandable_text_widget.dart';
import 'package:just_travel/views/widgets/image_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../models/db-models/trip_model.dart';
import '../../../providers/trip_provider.dart';

class TripDetailsPage extends StatelessWidget {
  static const routeName = '/home/trip-details-page';
  final String id;
  TripDetailsPage({required this.id, Key? key}) : super(key: key);
  RoomModel? roomModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: appbarLayout(
      //   title: 'Details',
      //   backgroundColor: Colors.black.withOpacity(0.7),
      //   systemOverlayStyle: StatusBarTheme.statusBarDart,
      // ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<TripModel?>(
            future: context.read<TripProvider>().getTripByTripId(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                TripModel? trip = snapshot.data;
                context.read<HotelProvider>().getHotelById(trip!.hotel!);
                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    // cover image
                    Stack(
                      children: [
                        CoverPhoto(imagePath: trip.photos![0]),
                        Positioned(
                          // top: 35,
                          left: 10,
                          child: BackButtonCustom(onBack: () {
                            Navigator.pop(context);
                          }),
                        ),
                      ],
                    ),

                    // trip title card
                    TripTitleCard(trip: trip),

                    // trip plan
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Trip Plan',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ExpandableTextWidget(text: trip.description!),

                    //  trip images grid
                    ImageGridView(imageList: trip.photos!),

                    // hotel
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Hotel Details',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          HotelListTile(
                            onSelectRoom: (roomModel) {
                              this.roomModel = roomModel;
                              context
                                  .read<TripProvider>()
                                  .costCalculate(trip, roomModel);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),

                    // JOIN Card
                    CheckUserTrip(
                      onTrue: Consumer<TripProvider>(
                          builder: (context, provider, child) {
                        return JoinCard(
                          tripModel: trip,
                          roomModel: roomModel,
                          onJoin: provider.isRoomSelected
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    ConfirmPage.routeName,
                                    arguments: [trip, roomModel!],
                                  );
                                }
                              : null,
                        );
                      }),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text('Trip not found');
              }
              //
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
