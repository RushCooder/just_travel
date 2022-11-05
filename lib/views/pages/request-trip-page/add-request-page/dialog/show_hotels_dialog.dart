import 'package:flutter/material.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/views/pages/request-trip-page/add-request-page/components/hotel_list_tile.dart';
import 'package:just_travel/views/pages/request-trip-page/add-request-page/dialog/hotel_details_dialog.dart';
import 'package:provider/provider.dart';

showHotelsDialog({
  required BuildContext context,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recommendation Hotels'),
        content: Consumer<HotelProvider>(
          builder: (context, hotelProvider, child) =>
              hotelProvider.hotelsByDistrict.isEmpty
                  ? const Text('No hotel found')
                  : SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: hotelProvider.hotelsByDistrict.length,
                        itemBuilder: (context, index) {
                          final hotel = hotelProvider.hotelsByDistrict[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: HotelListTile(
                              hotel: hotel,
                              onTap: () {
                                hotelDetailsDialog(
                                  context: context,
                                  hotelId: hotel.id!,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
