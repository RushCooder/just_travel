import 'package:flutter/material.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/urls.dart';
import '../../../pages/trip-details-page/trip_details_page.dart';
import 'trip_card.dart';

class UpComingTrip extends StatelessWidget {
  const UpComingTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        // print('trips: ${tripProvider.tripList}');
        return tripProvider.tripList.isEmpty
            ? const Center(
                child: Text('There is no trip'),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                ),
                itemCount: tripProvider.tripList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TripDetailsPage.routeName,
                        arguments: tripProvider.tripList[index].id!);
                  },
                  child: TripCard(
                    title: tripProvider.tripList[index].placeName!,
                    location: tripProvider.tripList[index].city!,
                    image:
                        '${baseUrl}uploads/${tripProvider.tripList[index].photos![0]}',
                    date: tripProvider.tripList[index].startDate != null
                        ? getFormattedDateTime(
                            dateTime: tripProvider.tripList[index].startDate!)
                        : '00/00/0000',
                  ),
                ),
              );
      },
    );
  }
}
