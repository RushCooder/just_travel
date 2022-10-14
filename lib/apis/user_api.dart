import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../utils/constants/urls.dart';

class UserApi {
  //create user
  static Future<UserModel?> createUser(UserModel user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}users/create'));
    request.body = json.encode(user);
    request.headers.addAll(headers);

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        UserModel user = UserModel.fromJson(data);
        print('create user: $user');
        return user;
      } else {
        throw Error();
      }
    } catch (error) {
      print('create user error: $error');
      return null;
    }
  }

  // update user
  static Future<UserModel?> updateUser(Map<String, dynamic> map, String userId) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = Request('PATCH', Uri.parse('${baseUrl}users/$userId'));
    request.body = json.encode(map);
    // {
    //   "email.isVerified": true
    // }
    request.headers.addAll(headers);

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        UserModel user = UserModel.fromJson(data);
        print('updateUser user: $user');
        return user;
      } else {
        throw Error();
      }
    } catch (error) {
      print('create user error: $error');
      return null;
    }
  }



  // fetching user by email
  static Future<UserModel?> fetchUserByEmail(String email) async {
    try {
      var request =
          Request('GET', Uri.parse('${baseUrl}users/email/?email=$email'));

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('user error: $error');
      return null;
    }
  }
}
