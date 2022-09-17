import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_travel/apis/user_api.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../apis/image_upload_api.dart';
import '../models/db-models/image_upload_model.dart';

class UserProvider extends ChangeNotifier{
  UserModel? user;


/*
  * Image picking section start*/
  ImageSource _imageSource = ImageSource.camera;
  String? userImagePath;
  XFile? userImageFile;

  void reset(){
    userImagePath = null;
    userImageFile = null;
  }

  Future<ImageUploadModel?> userPickImage(bool isCamera) async {
    if (isCamera) {
      _imageSource = ImageSource.camera;
    } else {
      _imageSource = ImageSource.gallery;
    }
    userImageFile =
    await ImagePicker().pickImage(source: _imageSource, imageQuality: 50);
    if (userImageFile != null) {
      try {
        ImageUploadModel? uploadModel =
        await ImageUploadApi.uploadImage(userImageFile!.path);
        userImagePath = uploadModel!.image;

        print('picked image: $userImagePath');
        notifyListeners();
        return uploadModel;
      } catch (e) {
        print('user provider -> image upload: $e');

      }
    }
    return null;
  }
  /*
  * Image picking section end*/



  /*
  * Database query*/
  Future<void> fetchUserByEmail(String email) async {
    user = await UserApi.fetchUserByEmail(email);
    notifyListeners();
  }

}