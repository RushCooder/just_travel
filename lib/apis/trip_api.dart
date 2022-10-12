import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel/models/db-models/join_model.dart';
import '../models/db-models/trip_model.dart';
import '../utils/constants/urls.dart';

class TripApi {
  /* ========================== Insertion ====================== ***
  * */
  // join trip
  static Future<bool> joinTrip(JoinModel joinModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}join/join'));
    request.body = json.encode(joinModel.toJson());
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        throw Error();
      }
    } catch (e) {
      print('failed because: $e');
      return false;
    }
  }

  /*
  * ========== query ==========*/
  static Future<List<TripModel>> getAllTrips() async {
    var request = Request('GET', Uri.parse('${baseUrl}trips'));
    StreamedResponse response = await request.send();
    // print('in api trip');
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<TripModel> tripModels = List.generate(
        data.length,
        (index) => TripModel.fromJson(data[index]),
      );

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
      return trip;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static Future<TripModel?> getTripByUserId(
      String userId, String tripId) async {
    var request = Request('GET', Uri.parse('${baseUrl}join/$userId/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        TripModel trip = TripModel.fromJson(decodedData[0]['tripId']);
        // print('trip found');
        return trip;
      } else {
        print(response.reasonPhrase);
        throw Error();
      }
    } catch (e) {
      print('failed because: $e');
      return null;
    }
  }
}
