import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Empty List'),
          ),
        ),
      ),
    );
  }
}
