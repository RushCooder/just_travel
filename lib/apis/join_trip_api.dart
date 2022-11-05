import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../models/db-models/join_model.dart';
import '../utils/constants/urls.dart';

class JoinTripApi {
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

  // fetch users in a trip by trip id
  static Future<Map<String, dynamic>> getUsersByTripId(String tripId) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}join/users/trip/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        List<UserModel> users = List.generate(decodedData.length,
            (index) => UserModel.fromJson(decodedData[0]['userId']));

        List<num> numberOfTravelers = List.generate(decodedData.length,
            (index) => decodedData[index]['numberOfTravellers']);
        // print('trip found');
        return {
          'users': users,
          'numberOfTravellers' : numberOfTravelers,
        };
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return {};
    }
  }

  // count joined users in a trip by trip id
  static Future<num> countUsersInTrip(String tripId) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}join/users/count/trip/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        num userCount = jsonDecode(await response.stream.bytesToString());
        return userCount;
      } else {
        print(response.reasonPhrase);
        throw Error();
      }
    } catch (e) {
      print('failed because: $e');
      return 0;
    }
  }
}
