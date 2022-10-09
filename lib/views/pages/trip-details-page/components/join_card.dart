import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/constants/symbols.dart';
import 'package:provider/provider.dart';

class JoinCard extends StatelessWidget {
  RoomModel? roomModel;
  final TripModel tripModel;
  VoidCallback? onJoin;
  JoinCard({ required this.tripModel, required this.roomModel, required this.onJoin, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Cost',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 17),
                  ),
                  Row(
                    children: [
                      Consumer<TripProvider>(
                        builder:(context, provider, child) =>  Text(
                          '$currencySymbol${provider.totalCost}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '/Person',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: onJoin,
                  child: const Text('JOIN'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
