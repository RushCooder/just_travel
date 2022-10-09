import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_travel/models/db-models/join_model.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/theme/status_bar_theme.dart';
import 'package:just_travel/views/pages/trip-details-page/components/cover_photo.dart';
import 'package:just_travel/views/pages/trip-details-page/components/hotel_list_tile.dart';
import 'package:just_travel/views/pages/trip-details-page/components/join_card.dart';
import 'package:just_travel/views/pages/trip-details-page/components/trip_title_card.dart';
import 'package:just_travel/views/widgets/appbar_layout.dart';
import 'package:just_travel/views/widgets/expandable_text_widget.dart';
import 'package:just_travel/views/widgets/image_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../models/db-models/trip_model.dart';
import '../../../providers/trip_provider.dart';
import '../../../utils/constants/urls.dart';

class TripDetailsPage extends StatelessWidget {
  static const routeName = '/home/trip-details-page';
  final String id;
  TripDetailsPage({required this.id, Key? key}) : super(key: key);
  RoomModel? roomModel;

  // void onSelectRoom(RoomModel roomModel){
  //   print('tirp details: $roomModel');
  //   this.roomModel = roomModel;
  //
  // }

  @override
  Widget build(BuildContext context) {
    context.read<TripProvider>().getTripById(id);
    // context.read<TripProvider>().costCalculate(trip, room);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbarLayout(
        title: 'Details',
        backgroundColor: Colors.black.withOpacity(0.2),
        systemOverlayStyle: StatusBarTheme.statusBarDart,
      ),
      body: Center(
        child: FutureBuilder<TripModel?>(
          future: context.read<TripProvider>().getTripById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              TripModel? trip = snapshot.data;
              context.read<HotelProvider>().getHotelById(trip!.hotel!);
              return ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  // cover image
                  CoverPhoto(imagePath: trip.photos![0]),

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
                            print('tirp details: $roomModel');
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
                  Consumer<TripProvider>(builder: (context, provider, child) {
                    return JoinCard(
                      tripModel: trip,
                      roomModel: roomModel,
                      onJoin: provider.isRoomSelected ? (){
                        print('trip name: ${trip.placeName}');
                        print('trip id: ${trip.id}');

                        print('room title: ${roomModel?.title}');
                        print('room id: ${roomModel?.id}');

                        String? userName = context.read<UserProvider>().user!.name!;
                        String? userId = context.read<UserProvider>().user!.id!;

                        print('user name: $userName');
                        print('user id: $userId');

                        print('join clicked');
                      } : null,
                    );
                  }),
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
    );
  }
}