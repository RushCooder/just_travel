import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/constants/symbols.dart';
import 'package:provider/provider.dart';

class PaymentSummaryCard extends StatelessWidget {
  final TripModel trip;
  final RoomModel room;
  final num numberOfTravellers;

  const PaymentSummaryCard({required this.trip, required this.room, required this.numberOfTravellers, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Package With Transport'),
              trailing: Text('$currencySymbol${numberOfTravellers}x${trip.cost}'),
            ),
            ListTile(
              title: const Text('Hotel & Resort'),
              trailing: Text('$currencySymbol${room.price}'),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              title: Text(
                'Grand Total',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 15,
                    ),
              ),
              trailing: Text(
                '$currencySymbol${context.read<TripProvider>().totalCost}',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 15,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
