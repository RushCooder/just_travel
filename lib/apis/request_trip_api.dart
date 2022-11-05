import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:just_travel/models/db-models/request_trip_model.dart';
import 'package:just_travel/utils/constants/urls.dart';

class RequestTripApi {
  // creating new requested trip
  static Future<bool> requestTrip(RequestTripModel requestTripModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}request_trip'));
    request.body = json.encode(requestTripModel.toJson());
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        debugPrint(await response.stream.bytesToString());
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      debugPrint('failed to create requested trip: $e');
      return false;
    }
  }

  // update requested trip
  static Future<bool> updateRequestedTrip(
      String requestedTripId, Map<String, dynamic> map,) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        Request('POST', Uri.parse('${baseUrl}request_trip/$requestedTripId'));

    request.body = json.encode(map);
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        debugPrint(await response.stream.bytesToString());
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      debugPrint('failed to create requested trip: $e');
      return false;
    }
  }

  /*
  * ========== query ==========*/
  static Future<List<RequestTripModel>> getAllRequestedTrips() async {
    var request = Request('GET', Uri.parse('${baseUrl}request_trip/filter'));
    StreamedResponse response = await request.send();
    // print('in api trip');
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<RequestTripModel> requestedTrips = List.generate(
        data.length,
            (index) => RequestTripModel.fromJson(data[index]),
      );

      return requestedTrips;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }


  // get requested trip by request trip id
  static Future<RequestTripModel?> getRequestedTripByRequestTripId(
      String requestTripId) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}request_trip/$requestTripId'));

    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        return RequestTripModel.fromJson(decodedData);
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      debugPrint('failed to create requested trip: $e');
      return null;
    }
  }

  // get requested trip by request trip id
  static Future<List<RequestTripModel>> getRequestedTripsByUserId(
      String userId) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}request_trip/user/$userId'));

    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        return List.generate(decodedData.length,
            (index) => RequestTripModel.fromJson(decodedData[index]));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      debugPrint('failed to create requested trip: $e');
      return [];
    }
  }


}
