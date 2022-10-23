import 'package:flutter/material.dart';

class UserMessageSide extends StatelessWidget {
  const UserMessageSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
        ),
        const SizedBox(width: 10,),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('hi'),
        ),
      ],
    );

  }
}
