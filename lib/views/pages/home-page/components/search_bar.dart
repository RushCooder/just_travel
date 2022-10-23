import 'package:flutter/material.dart';
import 'package:just_travel/views/pages/trip-details-page/trip_details_page.dart';
import 'package:just_travel/views/widgets/trip_search_delegate.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final resultTrip = await showSearch(context: context, delegate: TripSearchDelegate());
        if (resultTrip != null){
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, TripDetailsPage.routeName, arguments: resultTrip.id);
        }
      },
      child: Container(
        height: 41,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueGrey.shade800,
              child: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            Center(
              child: Text(
                'Search your dream trip',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
