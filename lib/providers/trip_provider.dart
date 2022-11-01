import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:just_travel/models/db-models/join_model.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../apis/image_upload_api.dart';
import '../apis/trip_api.dart';
import '../models/db-models/image_upload_model.dart';
import '../models/db-models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  List<TripModel> tripList = [];
  List<TripModel> myTripsList = [];
  TripModel? tripModel;
  num? totalCost;
  bool isRoomSelected = false;
  bool isJoined = false;

  void setRoomSelectedStatus(bool status) {
    isRoomSelected = status;
    notifyListeners();
  }

  void reset() {
    isRoomSelected = false;
    totalCost = null;
    notifyListeners();
  }

  // calculating total cost
  void costCalculate(TripModel trip, num numberOfTravellers, RoomModel? room) {
    if (room == null) {
      totalCost = trip.cost;
    } else {
      totalCost = ((trip.cost! * numberOfTravellers) + room.price!);
    }

    notifyListeners();
  }

  /* ========================== Insertion ====================== ***
  * */
  // join trip
  Future<void> joinTrip(TripModel trip, RoomModel room, UserModel user, num numberOfTravellers) async {
    JoinModel joinModel = JoinModel(
        tripId: trip.id,
        roomId: room.id,
        userId: user.id,
        numberOfTravellers: numberOfTravellers,
        status: 'Pending',
        startDate: trip.startDate,
        endDate: trip.endDate,
        totalCost: totalCost);
    print('trip join: $joinModel');
    isJoined = await TripApi.joinTrip(joinModel);
    notifyListeners();
  }

/*
  * ============= query ============*/
  // get all trips
  Future<List<TripModel>> getAllTrips() async {
    try {
      tripList = await TripApi.getAllTrips();
      notifyListeners();
      return tripList;
    } catch (e) {
      print('Error: $e');
      return tripList;
    }
  }

  // get trip by tripId
  Future<TripModel?> getTripByTripId(String tripId) async {
    tripModel = await TripApi.getTripByTripId(tripId);
    notifyListeners();
    costCalculate(tripModel!, 1, null);
    return tripModel;
  }

  // fetching trip by userId tripId
  Future<bool> getTripByUserIdTripId(String userId, String tripId) async {
    TripModel? trip = await TripApi.getTripByUserIdTripId(userId, tripId);
    return trip?.placeName != null;
  }

  // fetching trip by userId
  Future<void> getTripByUserId(String userId) async {
    myTripsList = await TripApi.getTripsByUserId(userId);
    notifyListeners();
  }
}
