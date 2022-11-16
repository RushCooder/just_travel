import 'package:flutter/material.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/urls.dart';
import '../../trip-details-page/trip_details_page.dart';
import 'trip_card.dart';

class UpComingTrip extends StatelessWidget {
  const UpComingTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: AppText(
            title: 'Upcoming Trip',
          ),
        ),
        Consumer<TripProvider>(
          builder: (context, tripProvider, child) {
            // print('trips: ${tripProvider.tripList}');
            return tripProvider.tripList.isEmpty
                ? tripProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(
                        child: Text('There is no trip'),
                      )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                        location: tripProvider.tripList[index].district!,
                        image:
                            '${baseUrl}uploads/${tripProvider.tripList[index].photos![0]}',
                        startDate:
                            tripProvider.tripList[index].startDate != null
                                ? getFormattedDateTime(
                                    dateTime:
                                        tripProvider.tripList[index].startDate!,
                                    pattern: 'MMM dd, yyyy',
                                  )
                                : '00/00/0000',
                        endDate: tripProvider.tripList[index].endDate != null
                            ? getFormattedDateTime(
                                dateTime: tripProvider.tripList[index].endDate!,
                                pattern: 'MMM dd, yyyy',
                              )
                            : '00/00/0000',
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
