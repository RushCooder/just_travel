import 'package:flutter/material.dart';
import 'package:just_travel/utils/constants/symbols.dart';

class ItemTile extends StatelessWidget {
  final String title, subTitle;
  final num cost;
  final IconData icon;
  const ItemTile({
    required this.title,
    required this.subTitle,
    required this.cost,
    required this.icon,
    Key? key,
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
      subtitle: Text(
        title,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 15,
              color: Colors.black,
            ),
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
