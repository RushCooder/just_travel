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

  /*
  * hotel methods*/
  reset() {
    hotelModel = null;
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
}
