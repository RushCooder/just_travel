import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../apis/image_upload_api.dart';
import '../apis/trip_api.dart';
import '../models/db-models/image_upload_model.dart';
import '../models/db-models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  List<TripModel> tripList = [];
  TripModel? tripModel;

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
    return tripModel;
  }

}
