import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/utils/constants/symbols.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/views/pages/trip-details-page/dialog/room_details_dialog.dart';
import 'package:just_travel/views/widgets/network_image_loader.dart';
import 'package:provider/provider.dart';

showRoomsDialog({
  required BuildContext context,
  required TripModel trip,
  required Function(RoomModel roomModel) onSelectRoom,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rooms for your selection'),
        content: Consumer<RoomProvider>(
          builder: (context, roomProvider, child) =>
              roomProvider.roomList.isEmpty
                  ? const Text('No room found')
                  : SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: roomProvider.roomList.length,
                        itemBuilder: (context, index) {
                          final room = roomProvider.roomList[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            // todo: need to replace ListTile with other widget to fix render error

                            child: ListTile(
                              onTap: () {
                                roomDetailsDialog(
                                    context: context,
                                    roomId: room.id!,
                                    trip: trip,
                                    onSelectRoom: onSelectRoom);
                              },
                              leading: SizedBox(
                                width: 50,
                                height: 100,
                                child: room.photos == null
                                    ? Image.asset(
                                        'images/img.png',
                                        width: 50,
                                        height: 100,
                                      )
                                    : NetworkImageLoader(
                                        image:
                                            '${baseUrl}uploads/${room.photos![0]}',
                                        width: 50,
                                        height: 100,
                                      ),
                              ),
                              title: Text(room.title!),
                              subtitle: Text('Peoples: ${room.maxCapacity}'),
                              trailing: Text(
                                '$currencySymbol${room.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
