import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_travel/models/db-models/join_model.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../apis/image_upload_api.dart';
import '../apis/trip_api.dart';
import '../models/db-models/image_upload_model.dart';
import '../models/db-models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  DateTime? tripStartDate, tripEndDate;
  List<String> tripImageList = [];
  ImageSource _imageSource = ImageSource.camera;
  String? tripImagePath;
  XFile? tripImageFile;

  List<TripModel> tripList = [];
  List<TripModel> myTripsList = [];
  List<TripModel> hostTripList = [];
  TripModel? tripModel;

  bool isLoading = false;

  // on init
  void onInit(){
    getAllTrips();
  }

  void reset() {
    tripImageList = [];
    tripStartDate = null;
    tripEndDate = null;
    tripImagePath = null;
    tripImageFile = null;
    notifyListeners();
  }

  void setTripStartDate(DateTime? dateTime) {
    tripStartDate = dateTime;
    if (tripEndDate != null) {
      if (tripStartDate?.compareTo(tripEndDate!) != -1) {
        tripEndDate = null;
      }
    }
    notifyListeners();
  }

  void setTripEndDate(DateTime? dateTime) {
    tripEndDate = dateTime;
    notifyListeners();
  }

  /*
  * Image picking section start*/
  Future<void> tripPickImage(bool isCamera, {required int index}) async {
    if (isCamera) {
      _imageSource = ImageSource.camera;
    } else {
      _imageSource = ImageSource.gallery;
    }
    tripImageFile =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 50);
    if (tripImageFile != null) {
      try {
        ImageUploadModel? uploadModel =
            await ImageUploadApi.uploadImage(tripImageFile!.path);
        if (index < 0) {
          tripImageList.add(uploadModel!.image!);
        } else {
          tripImageList[index] = uploadModel!.image!;
        }
        print('images: ${tripImageList}');
        notifyListeners();
      } catch (e) {
        print('trip provider -> image upload: $e');
      }
    }
  }
  /*
  * Image picking section end*/

  /* ========================== Insertion ====================== ***
  * */
  // create request trip
  Future<bool> requestTrip({
    required String placeName,
    required String district,
    required String division,
    required String description,
    required String hotelId,
    required String userId,
    required num totalCost,
    required num travellers,
  }) async {
    final TripModel tripModel = TripModel(
      placeName: placeName,
      description: description,
      district: district,
      division: division,
      startDate: tripStartDate?.millisecondsSinceEpoch,
      endDate: tripEndDate?.millisecondsSinceEpoch,
      photos: tripImageList,
      travellers: travellers,
      cost: totalCost,
      hotel: hotelId,
      host: userId,
      status: 'pending',
    );
    return await TripApi.createTrip(tripModel);
  }


/*
  * ============= query ============*/
  // get all trips
  Future<List<TripModel>> getAllTrips() async {
    try {
      isLoading = true;
      notifyListeners();
      tripList = await TripApi.getAllTrips();
      isLoading = false;
      notifyListeners();
      return tripList;
    } catch (e) {
      print('Error: $e');
      isLoading = false;
      notifyListeners();
      return tripList;
    }
  }

  // get trips host
  Future<List<TripModel>> getTripsByHost(String host) async {
    try {
      hostTripList = await TripApi.getTripsByHost(host);
      notifyListeners();
      return hostTripList;
    } catch (e) {
      print('Error: $e');
      return hostTripList;
    }
  }

  // get trip by tripId
  Future<TripModel?> getTripByTripId(String tripId) async {
    tripModel = await TripApi.getTripByTripId(tripId);
    notifyListeners();
    // costCalculate(tripModel!, 1, null);
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
