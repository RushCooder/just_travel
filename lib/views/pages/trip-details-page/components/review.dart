import 'package:flutter/material.dart';
import 'package:just_travel/providers/review_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/home-page/components/app_bar_trailing.dart';
import 'package:just_travel/views/pages/trip-details-page/dialog/add_review_dialog.dart';
import 'package:just_travel/views/widgets/circular_image_layout.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';
import 'package:just_travel/views/widgets/network_image_loader.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/urls.dart';
import '../../../widgets/profile_circular_image.dart';

class Review extends StatelessWidget {
  String tripId;
  Review({required this.tripId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<ReviewProvider>().getAllReviewByTripId(tripId);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<ReviewProvider>(
            builder: (context, reviewProvider, child) {
              return reviewProvider.reviewList.isEmpty
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Package Review',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // review add button
                        FutureBuilder(
                          future: context
                              .read<ReviewProvider>()
                              .checkEligibilityReview(
                                context.read<UserProvider>().user!.id!,
                                tripId,
                              ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final isEligible = snapshot.data;
                              if (isEligible != null && isEligible == true) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                    ),
                                    onPressed: () {
                                      addReviewDialog(
                                          context: context, tripId: tripId);
                                    },
                                    child: const Text('Add Review'),
                                  ),
                                );
                              }
                              return const SizedBox();
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('Server Error'),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviewProvider.reviewList.length,
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: context
                                      .read<UserProvider>()
                                      .fetchUserByUserId(reviewProvider
                                          .reviewList[index].user!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final user = snapshot.data;
                                      return ListTile(
                                        leading: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: user!.profileImage == null
                                              ? CircleAvatar(
                                                  radius: 50,
                                                  child: Text(
                                                    user.name!.substring(0, 2),
                                                  ),
                                                )
                                              : CircularImageLayout(
                                                  radius: 50,
                                                  width: 50,
                                                  height: 50,
                                                  image:
                                                      '${baseUrl}uploads/${user.profileImage}',
                                                ),
                                        ),
                                        title: Text(
                                          '${user.name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7),
                                          child: Text(
                                            '${reviewProvider.reviewList[index].review}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  fontSize: 15,
                                                ),
                                          ),
                                        ),
                                        trailing: Text(
                                          getFormattedDateTime(
                                            dateTime: reviewProvider
                                                .reviewList[index].date!,
                                            pattern: 'MMM dd, yyyy',
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: Text('Server Error'),
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}
