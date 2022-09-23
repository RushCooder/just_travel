import 'package:flutter/material.dart';

import '../../../widgets/app_text.dart';

class TravelCard extends StatelessWidget {
  final String title;
  final String location;
  final String image;
  final String availableDate;

  const TravelCard({
    required this.title,
    required this.location,
    required this.image,
    required this.availableDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              image,
              height: 150,
              width: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ListTile(
              title: AppText(
                title: title,
                fontSize: 15,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 10,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      AppText(
                        title: location,
                        isTitle: false,
                        fontSize: 11,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_sharp,
                        size: 10,
                        color: Colors.cyan,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      AppText(
                        title: availableDate,
                        isTitle: false,
                        fontSize: 11,
                      ),
                    ],
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
