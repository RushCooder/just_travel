import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:just_travel/models/db-models/room_model.dart';

import '../apis/image_upload_api.dart';
import '../apis/trip_api.dart';
import '../models/db-models/image_upload_model.dart';
import '../models/db-models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  List<TripModel> tripList = [];
  TripModel? tripModel;
  num? totalCost;
  bool isRoomSelected = false;

  void setRoomSelectedStatus(bool status){
    isRoomSelected = status;
    notifyListeners();
  }

  void resetValue(){
    isRoomSelected = false;
    totalCost = null;
    notifyListeners();
  }

/*
  * ============= query ============*/
  // get all trips
  Future<List<TripModel>> getAllTrips() async {
    print('getAllHotels');
    try {
      tripList = await TripApi.getAllTrips();
      notifyListeners();
      return tripList;
    } catch (e) {
      print('Error: $e');
      return tripList;
    }
  }

  // get trip by id
  Future<TripModel?> getTripById(String tripId) async {
    tripModel = await TripApi.getTripById(tripId);
    notifyListeners();
    costCalculate(tripModel!, null);
    return tripModel;
  }

  void costCalculate(TripModel trip, RoomModel? room){
    if (room == null) {
      totalCost = trip.cost;
    }
    else{
      totalCost = (trip.cost! + (room.price! ~/ room.maxCapacity!));
    }

    notifyListeners();
  }

}
