import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel/models/db-models/join_model.dart';
import '../models/db-models/trip_model.dart';
import '../utils/constants/urls.dart';

class TripApi {
  /* ========================== Insertion start ====================== ***
  * */

  // requesting create trip
  static Future<bool> createTrip(TripModel tripModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}trips/create'));
    request.body = json.encode(tripModel);
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        throw 'failed because: ${response.reasonPhrase}';
      }
    } catch (e) {
      print('failed: $e');
      return false;
    }
  }



  /* ========================== Insertion start ====================== ***
  * */

  /*
  * ========== query  start ==========*/
  static Future<List<TripModel>> getAllTrips() async {
    var request = Request('GET', Uri.parse('${baseUrl}trips/filter'));
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

  // get trips by host
  static Future<List<TripModel>> getTripsByHost(String host) async {
    var request = Request('GET', Uri.parse('${baseUrl}trips/host/$host'));
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
  static Future<TripModel?> getTripByTripId(String tripId) async {
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

  // fetching trip by userId tripId
  static Future<TripModel?> getTripByUserIdTripId(
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

  // fetching trip by userId
  static Future<List<TripModel>> getTripsByUserId(String userId) async {
    var request = Request('GET', Uri.parse('${baseUrl}join/$userId'));
    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        List<TripModel> trips = List.generate(
          decodedData.length,
          (index) => TripModel.fromJson(decodedData[index]['tripId']),
        );
        // print('trip found');
        return trips;
      } else {
        print(response.reasonPhrase);
        throw Error();
      }
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }
/*
  * ========== query  end ==========*/
}
