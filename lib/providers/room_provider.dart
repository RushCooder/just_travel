import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_travel/apis/room_api.dart';
import 'package:just_travel/models/db-models/room_model.dart';

import '../apis/image_upload_api.dart';
import '../models/db-models/image_upload_model.dart';

class RoomProvider extends ChangeNotifier {
  List<RoomModel> roomList = [];
  RoomModel? room;

  String? selectedRoomStatusGroupValue;
  String? selectedRoomStatus;
  num numberOfTravellers = 1;

  void setRoomStatus(String value) {
    selectedRoomStatusGroupValue = value;
    notifyListeners();
  }

  void setNumberOfPeople(num value) {
    numberOfTravellers = value;
    notifyListeners();
  }

  void reset() {
    numberOfTravellers = 1;
    selectedRoomStatusGroupValue = null;
    room = null;
    roomList = [];
    notifyListeners();
  }
  /*
  *============================ Room api calling section ============================*/

/*
* ============= Query =============*/

// get rooms by hotel id
  Future<List<RoomModel>?> getRoomsByHotelId(String hotelId) async {
    try {
      roomList = await RoomApi.getRoomsByHotelId(hotelId);
      notifyListeners();
      return roomList;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // get rooms by room id
  Future<RoomModel?> getRoomsByRoomId(String id) async {
    try {
      room = await RoomApi.getRoomByRoomId(id);
      notifyListeners();
      return room;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // get rooms by hotelId status anc capacity
  Future<void> getRoomsByHotelIdStatusCapacity(String hotelId) async {
    try {
      if (selectedRoomStatusGroupValue != null) {
        roomList = await RoomApi.getRoomsByHotelIdStatusCapacity(
            hotelId, selectedRoomStatusGroupValue!, numberOfTravellers);
        notifyListeners();
      } else {
        throw 'Room status not selected';
      }
    } catch (error) {
      rethrow;
    }
  }
}
