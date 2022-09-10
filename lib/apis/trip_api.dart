import 'dart:convert';

import 'package:http/http.dart';

import '../models/db-models/trip_model.dart';
import '../utils/constants/urls.dart';

class TripApi{
  /*
  * ========== query ==========*/
  static Future<List<TripModel>> getAllTrips() async {
    print('in api trip');
    var request = Request('GET', Uri.parse('${baseUrl}trips'));
    StreamedResponse response = await request.send();
    print('in api trip');
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<TripModel> tripModels = List.generate(
        data.length,
            (index) => TripModel.fromJson(data[index]),
      );

      print(tripModels);
      return tripModels;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  // fetching trip by trip id
  static Future<TripModel?> getTripById(String tripId) async {
    var request = Request('GET', Uri.parse('${baseUrl}trips/$tripId'));
    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);
      TripModel trip = TripModel.fromJson(data);
      print('tripApi: $trip');
      return trip;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}