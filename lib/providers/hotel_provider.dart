import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../apis/hotel_api.dart';
import '../apis/image_upload_api.dart';
import '../models/db-models/hotel_model.dart';
import '../models/db-models/image_upload_model.dart';

class HotelProvider extends ChangeNotifier {
  /*
  * Hotels */
  List<HotelModel> hotelList = [];
  List<HotelModel> hotelsByCity = [];
  List<String> hotelTypeList = ['Five Start', 'Normal'];
  List<String> hotelImageList = [];
  String? selectedHotelType;
  ImageSource _imageSource = ImageSource.camera;
  String? hotelImagePath;
  XFile? hotelImageFile;

  HotelModel? hotelModel;

/*
  * Image picking section start*/
  Future<void> hotelPickImage(bool isCamera, {required int index}) async {
    if (isCamera) {
      _imageSource = ImageSource.camera;
    } else {
      _imageSource = ImageSource.gallery;
    }
    hotelImageFile =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 50);
    if (hotelImageFile != null) {
      try {
        // Uint8List imgByte = await hotelImageFile!.readAsBytes();
        ImageUploadModel? uploadModel =
            await ImageUploadApi.uploadImage(hotelImageFile!.path);
        if (index < 0) {
          hotelImageList.add(uploadModel!.image!);
        } else {
          hotelImageList[index] = uploadModel!.image!;
        }
        notifyListeners();
      } catch (e) {
        print('hotel provider -> image upload: $e');
      }
    }
  }
  /*
  * Image picking section end*/

  /*
  * hotel methods*/
  setSelectedHotelType(String? value) {
    selectedHotelType = value;
    notifyListeners();
  }

  setHotel(HotelModel? value) {
    hotelModel = value;
    notifyListeners();
  }

  reset() {
    hotelImageList = [];
    selectedHotelType = null;
    hotelModel = null;
    notifyListeners();
  }

  /*
  *============================ Hotel api calling section ============================*/

  // get all hotels
  Future<List<HotelModel>> getAllHotels() async {
    print('getAllHotels');
    try {
      hotelList = await HotelApi.getAllHotels();
      notifyListeners();
      return hotelList;
    } catch (e) {
      print('Error: $e');
      return hotelList;
    }
  }

  // get hotel by id
  Future<HotelModel?> getHotelById(String hotelId) async {
    hotelModel = await HotelApi.getHotelById(hotelId);
    notifyListeners();
    return hotelModel;
  }

  // get hotels by city
  Future<List<HotelModel>> getHotelsByCity(String city) async {
    print('getAllHotels');
    try {
      hotelsByCity = await HotelApi.getHotelByCity(city);
      print('hotel by city: $hotelsByCity');
      notifyListeners();
      return hotelsByCity;
    } catch (e) {
      print('Error: $e');
      return hotelsByCity;
    }
  }
}
