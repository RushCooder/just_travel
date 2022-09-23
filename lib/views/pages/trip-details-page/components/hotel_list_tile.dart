import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/views/pages/trip-details-page/dialog/show_rooms_dialog.dart';
import 'package:just_travel/views/widgets/expandable_text_widget.dart';
import 'package:just_travel/views/widgets/image_slider.dart';
import 'package:provider/provider.dart';

class HotelListTile extends StatelessWidget {
  const HotelListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelProvider>(
      builder: (context, hotelProvider, child) {
        final hotel = hotelProvider.hotelModel;
        return hotel == null
            ? const Text('No hotel found')
            : ExpandedTileList.builder(
                padding: const EdgeInsets.all(0),
                itemCount: 1,
                itemBuilder: (context, index, controller) {
                  return ExpandedTile(
                    theme: const ExpandedTileThemeData(
                      headerColor: Color(0x2C333300),
                      headerRadius: 12.0,
                      // headerPadding: EdgeInsets.all(24.0),
                      // headerSplashColor: Colors.red,
                      //
                      contentBackgroundColor: Color(0x2C333300),
                      // contentPadding: EdgeInsets.all(24.0),
                      contentRadius: 12.0,
                    ),
                    controller: controller,
                    // index == 2 ? controller.copyWith(isExpanded: true) : controller,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(hotel.name!),
                        Text(
                          hotel.type!,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    content: SizedBox(
                      height: 400,
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        // physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              showRoomsDialog(context, hotel.rooms!);
                            },
                            child: Text(
                              'Book Now',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ImageSlider(photos: hotel.photos!),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          ExpandableTextWidget(text: hotel.description!),
                        ],
                      ),
                    ),
                    onTap: () {
                      debugPrint("tapped!!");
                    },
                    onLongTap: () {
                      debugPrint("looooooooooong tapped!!");
                    },
                  );
                },
              );
      },
    );
  }
}
