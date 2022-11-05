import 'package:flutter/material.dart';
import 'package:just_travel/apis/join_trip_api.dart';
import 'package:just_travel/apis/trip_api.dart';

import '../models/db-models/join_model.dart';
import '../models/db-models/room_model.dart';
import '../models/db-models/trip_model.dart';
import '../models/db-models/user_model.dart';

class JoinTripProvider extends ChangeNotifier {
  List<num> numberOfTravelerList = [];
  List<UserModel> joinedUserList = [];

  num? totalCost;
  bool isJoined = false;

  void reset() {
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

  /*
   =============================== DB query =========================
  * */
  // join trip
  Future<void> joinTrip(TripModel trip, RoomModel room, UserModel user,
      num numberOfTravellers) async {
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
    isJoined = await JoinTripApi.joinTrip(joinModel);
    notifyListeners();
  }

  // fetch users in a trip by trip id
  Future<void> getUsersByTripId(String tripId) async {
    Map<String, dynamic> map = await JoinTripApi.getUsersByTripId(tripId);
    if (map.isNotEmpty) {
      joinedUserList = map['users'];
      numberOfTravelerList = map['numberOfTravellers'];
      notifyListeners();
    }
  }

  Future<num> countUsersInTrip(String tripId) async {
    return await JoinTripApi.countUsersInTrip(tripId);
  }
}
