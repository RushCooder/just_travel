import 'package:flutter/material.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/views/pages/request-trip-page/add-request-page/dialog/trip_image_picker_dialog.dart';
import 'package:just_travel/views/widgets/upload_image_card.dart';
import 'package:provider/provider.dart';

class UploadedImagesCard extends StatelessWidget {
  const UploadedImagesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Consumer<TripProvider>(
        builder: (context, tripProvider, child) {
          var tripImageList = tripProvider.tripImageList;
          return tripImageList.isEmpty
              ? Image.asset(
                  'images/img.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              : GridView.builder(
                  itemCount: tripImageList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) => UploadImageCard(
                    child: Consumer<TripProvider>(
                      builder: (context, provider, child) => Image.network(
                        '${baseUrl}uploads/${provider.tripImageList[index]}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      tripImagePickerDialog(context, index: index);
                    },
                  ),
                );
        },
      ),
    );
  }
}
