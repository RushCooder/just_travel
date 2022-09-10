import 'package:flutter/material.dart';
import 'package:just_travel/apis/user_api.dart';
import 'package:just_travel/models/db-models/user_model.dart';

class UserProvider extends ChangeNotifier{
  UserModel? user;

  Future<void> fetchUserByEmail(String email) async {
    user = await UserApi.fetchUserByEmail(email);
    notifyListeners();
  }

}