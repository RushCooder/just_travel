import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final String title;
  final String location;
  final String image;
  final String date;

  const TripCard({
    required this.title,
    required this.location,
    required this.image,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              image,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration:  BoxDecoration(
                color: Colors.white.withOpacity(0.7),
              ),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(location, style: Theme.of(context).textTheme.overline),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
