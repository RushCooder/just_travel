import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/request_trip_model.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/join_trip_provider.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/utils/constants/symbols.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/views/pages/trip-details-page/dialog/room_details_dialog.dart';
import 'package:just_travel/views/widgets/network_image_loader.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

showTravelersDialog({
  required BuildContext context,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All Joined Travelers'),
        elevation: 5,
        content: Consumer<JoinTripProvider>(
          builder: (context, joinTripProvider, child) =>
              joinTripProvider.joinedUserList.isEmpty
                  ? const Text('No joinedUser found')
                  : SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: joinTripProvider.joinedUserList.length,
                        itemBuilder: (context, index) {
                          final joinedUser = joinTripProvider.joinedUserList[index];
                          final numberOfTravelers = joinTripProvider.numberOfTravelerList[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            // todo: need to replace ListTile with other widget to fix render error

                            child: ListTile(
                              onTap: () {
                              },
                              leading: SizedBox(
                                width: 50,
                                height: 100,
                                child: joinedUser.profileImage == null
                                    ? Image.asset(
                                        'images/img.png',
                                        width: 50,
                                        height: 100,
                                      )
                                    : NetworkImageLoader(
                                        image:
                                            '${baseUrl}uploads/${joinedUser.profileImage}',
                                        width: 50,
                                        height: 100,
                                      ),
                              ),
                              title: Text(joinedUser.name!),
                              subtitle: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text('${joinedUser.email?.emailId}')),
                              trailing: Text(
                                '$numberOfTravelers',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
