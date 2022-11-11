import 'package:flutter/material.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class NumberOfTravelerPicker extends StatelessWidget {
  int maxValue;
  NumberOfTravelerPicker({this.maxValue = 5, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Number of Travellers:',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 16,
                ),
          ),
          Consumer<RoomProvider>(
            builder: (context, roomProvider, child) => NumberPicker(
              value: roomProvider.numberOfTravellers.toInt(),
              minValue: 1,
              maxValue: maxValue,
              itemCount: 2,
              itemHeight: 30,
              onChanged: (value) {
                roomProvider.setNumberOfPeople(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
