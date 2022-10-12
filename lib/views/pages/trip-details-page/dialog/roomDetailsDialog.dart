import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/constants/symbols.dart';
import 'package:just_travel/views/pages/trip-details-page/trip_details_page.dart';
import 'package:just_travel/views/widgets/expandable_text_widget.dart';
import 'package:just_travel/views/widgets/image_grid_view.dart';
import 'package:just_travel/views/widgets/image_slider.dart';
import 'package:provider/provider.dart';

roomDetailsDialog(BuildContext context, String roomId, Function(RoomModel roomModel) onSelectRoom) async {
  await context.read<RoomProvider>().getRoomsById(roomId);
  showDialog(
      context: context,
      builder: (context) => Consumer<RoomProvider>(
            builder: (context, roomProvider, child) {
              final room = roomProvider.room;
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: room == null
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
                            title: Text(room!.title!,
                                style: Theme.of(context).textTheme.headline6),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(room!.status!),
                                Text('Capacity ${room!.maxCapacity}'),
                              ],
                            ),
                            trailing: Text(
                              '$currencySymbol${room!.price!}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                      ),
                content: room == null
                    ? const Text('No room found')
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(0),
                        child: ListView(
                          padding: const EdgeInsets.all(0),
                          children: [
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: room!.photos!.length >= 4
                                  ? ImageGridView(
                                      imageList: room!.photos!,
                                    )
                                  : ImageSlider(photos: room!.photos!),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ExpandableTextWidget(text: room!.description!),
                          ],
                        ),
                      ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        onSelectRoom(room!);
                        context.read<TripProvider>().setRoomSelectedStatus(true);
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      },
                      child: const Text('BOOK NOW'),
                    ),
                  ),
                ],
              );
            },
          ));
}
