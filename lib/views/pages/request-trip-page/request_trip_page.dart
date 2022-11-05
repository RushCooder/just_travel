import 'package:flutter/material.dart';
import 'package:just_travel/providers/districts_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/request-trip-page/add-request-page/add_request_page.dart';
import 'package:just_travel/views/pages/request-trip-page/host-trip-details-page/host-trip_details_page.dart';
import 'package:just_travel/views/pages/trip-details-page/trip_details_page.dart';
import 'package:just_travel/views/widgets/network_image_loader.dart';
import 'package:provider/provider.dart';

class RequestTripsPage extends StatelessWidget {
  static const routeName = '/request_trips_page';

  const RequestTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requested Trips'),
      ),
      body: Consumer<TripProvider>(
        builder: (context, tripProvider, child) {
          return tripProvider.hostTripList.isEmpty
              ? const Center(
                  child: Text('Empty'),
                )
              : ListView.builder(
                  itemCount: tripProvider.hostTripList.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                         HostTripDetailsPage.routeName,
                        arguments: tripProvider.hostTripList[index].id,
                      );
                      // Navigator.pushNamed(
                      //     context, RequestedTripDetailsPage.routeName,
                      //     arguments: tripProvider.hostTripList[index].id);
                    },
                    leading: SizedBox(
                      width: 50,
                      height: 100,
                      child: tripProvider.hostTripList[index].photos == null
                          ? Image.asset(
                              'images/img.png',
                              width: 50,
                              height: 100,
                            )
                          : NetworkImageLoader(
                              image:
                                  '${baseUrl}uploads/${tripProvider.hostTripList[index].photos![0]}',
                              width: 50,
                              height: 100,
                            ),
                    ),
                    title: Text(
                      tripProvider.hostTripList[index].placeName!,
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          getFormattedDateTime(
                            dateTime:
                                tripProvider.hostTripList[index].startDate!,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('To'),
                        ),
                        Text(
                          getFormattedDateTime(
                            dateTime: tripProvider.hostTripList[index].endDate!,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      tripProvider.hostTripList[index].status!,
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Request Trip',
        onPressed: () {
          context.read<DistrictsProvider>().getAllDivision();
          Navigator.pushNamed(context, AddRequestTripPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
