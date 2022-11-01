import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/views/widgets/trip_list_card.dart';
import 'package:provider/provider.dart';

// class TripSearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       )
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     IconButton(
//       onPressed: () {
//         close(context, '');
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return ListTile(
//       leading: const Icon(Icons.search),
//       title: Text(query),
//       onTap: () {
//         close(context, query);
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final filteredList = query.isEmpty ? cities :
//     cities.where((city) =>
//         city.toLowerCase().startsWith(query.toLowerCase())).toList();
//     return ListView.builder(
//       itemCount: filteredList.length,
//       itemBuilder: (context, index) => ListTile(
//         title: Text(filteredList[index]),
//         onTap: () {
//           query = filteredList[index];
//           close(context, query);
//         },
//       ),
//     );
//   }
//
// }

class TripSearchDelegate extends SearchDelegate<TripModel?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      leading:const Icon(Icons.search),
      title: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final tripList = context.read<TripProvider>().tripList;

    final filteredList = query.isEmpty
        ? []
        : tripList
            .where(
              (trip) => trip.placeName!.toLowerCase().startsWith(
                    query.toLowerCase(),
                  ),
            )
            .toList();
    
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) => TripListCard(trip: filteredList[index], onPressed: () {
        close(context, filteredList[index]);
      },),
    );
  }
}
