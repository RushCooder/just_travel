import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/constants/symbols.dart';
import 'package:just_travel/views/widgets/expandable_text_widget.dart';
import 'package:just_travel/views/widgets/image_grid_view.dart';
import 'package:just_travel/views/widgets/image_slider.dart';
import 'package:provider/provider.dart';

hotelDetailsDialog({
  required BuildContext context,
  required String hotelId,
  bool isBooked = false,
}) async {
  await context.read<HotelProvider>().getHotelById(hotelId);
  showDialog(
    context: context,
    builder: (context) => Consumer<HotelProvider>(
      builder: (context, hotelProvider, child) {
        final hotel = hotelProvider.hotelModel;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: hotel == null
              ? const Text('Error')
              : Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
// contentPadding: const EdgeInsets.all(0),
                      title: Text(hotel.name!,
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text('Status: ${hotel.type}'),
                      // trailing: Text(
                      //   '$currencySymbol${hotel.price}',
                      //   style: Theme.of(context).textTheme.caption!.copyWith(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w800,
                      //       ),
                      // ),
                    ),
                  ),
                ),
          content: hotel == null
              ? const Text('No hotel found')
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(0),
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      // ListTile(
                      //   title: const Text('Ratting'),
                      //   trailing: Text(
                      //     hotel.rating!.toString().toUpperCase(),
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline6!
                      //         .copyWith(fontSize: 14),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: hotel.photos!.length >= 4
                            ? ImageGridView(
                                imageList: hotel.photos!,
                              )
                            : ImageSlider(photos: hotel.photos!),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpandableTextWidget(text: hotel.description!),
                    ],
                  ),
                ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: const StadiumBorder(),
              ),
              onPressed: isBooked
                  ? null
                  : () {
                      context
                          .read<HotelProvider>()
                          .setFinalSelectedHotel(hotel!);
                      int count = 0;
                      Navigator.popUntil(
                        context,
                        (route) {
                          return count++ == 2;
                        },
                      );
                    },
              child: const Text('BOOK NOW'),
            )
          ],
        );
      },
    ),
  );
}
