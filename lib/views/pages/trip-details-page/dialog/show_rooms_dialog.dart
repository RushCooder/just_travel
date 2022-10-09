import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/views/pages/trip-details-page/dialog/roomDetailsDialog.dart';
import 'package:provider/provider.dart';

showRoomsDialog(BuildContext context, List<String> rooms, Function(RoomModel roomModel) onSelectRoom) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Room'),
        content: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: rooms.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                roomDetailsDialog(context, rooms[index], onSelectRoom);
                print('Clicked');
              },
              child: Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(

                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(15),
                    // ),
                    ),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // color: Color(0xffB3E8E5),
                  color: Color(0xff3BACB6),
                ),
              ),
            ),
          ),
        ),
      ),
    );
