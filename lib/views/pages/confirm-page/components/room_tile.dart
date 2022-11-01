import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/utils/constants/symbols.dart';

class RoomTile extends StatelessWidget {
  final String subTitle;
  final RoomModel room;
  final IconData icon;
  const RoomTile({
    required this.room,
    required this.icon,
    Key? key, required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Card(
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      title: Text(
        subTitle,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room.title!,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Text(
            'No.: ${room.roomNumber}',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
      // trailing: Text(
      //   '$currencySymbol$cost',
      //   style: Theme.of(context).textTheme.headline6!.copyWith(
      //         fontSize: 14,
      //       ),
      // ),
    );
  }
}
