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
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          HostTripDetailsPage.routeName,
                          arguments: tripProvider.hostTripList[index].id,
                        );
                      },
                      leading: SizedBox(
                        height: 200,
                        width: 100,
                        child: tripProvider.hostTripList[index].photos == null
                            ? Image.asset(
                                'images/img.png',
                                height: 200,
                                width: 100,
                              )
                            : NetworkImageLoader(
                                image:
                                    '${baseUrl}uploads/${tripProvider.hostTripList[index].photos![0]}',
                                width: 50,
                                height: 100,
                              ),
                      ),
                      title: Text(
                        tripProvider.hostTripList[index].placeName!
                            .toUpperCase(),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Joined Travelers: ${tripProvider.hostTripList[index].joinedPersons}',
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${getFormattedDateTime(dateTime: tripProvider.hostTripList[index].startDate!, pattern: 'MMM dd')} - ${getFormattedDateTime(dateTime: tripProvider.hostTripList[index].endDate!, pattern: 'MMM dd, yyyy')}',
                          ),
                        ],
                      ),
                      trailing: Text(
                        tripProvider.hostTripList[index].status!,
                      ),
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
