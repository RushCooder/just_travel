import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../apis/hotel_api.dart';
import '../apis/image_upload_api.dart';
import '../models/db-models/hotel_model.dart';
import '../models/db-models/image_upload_model.dart';

class HotelProvider extends ChangeNotifier {
  HotelModel? hotelModel;

  List<HotelModel> hotelList = [];
  List<HotelModel> hotelsByDistrict = [];

  HotelModel? finalSelectedHotel;


  /*
  * hotel methods*/
  // this will select hotel for booking
  setFinalSelectedHotel(HotelModel value) {
    finalSelectedHotel = value;
    notifyListeners();
  }


  setHotel(HotelModel? value) {
    hotelModel = value;
    notifyListeners();
  }

  reset() {
    hotelModel = null;
    finalSelectedHotel = null;
    hotelsByDistrict = [];

    notifyListeners();
  }


  /*
  *============================ Hotel api calling section ============================*/
  // get hotel by id
  Future<HotelModel?> getHotelById(String hotelId) async {
    hotelModel = await HotelApi.getHotelById(hotelId);
    notifyListeners();
    return hotelModel;
  }


  // get hotels by district
  Future<List<HotelModel>?> getHotelsByDistrict(String district) async {
    try {
      hotelsByDistrict = await HotelApi.getHotelByDistrict(district);
      notifyListeners();
      return hotelsByDistrict;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
