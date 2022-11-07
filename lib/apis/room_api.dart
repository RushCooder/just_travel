import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import '../utils/constants/urls.dart';

class RoomApi {
  // requesting create room to api
  static Future<RoomModel?> createRoom(RoomModel roomModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}rooms/create'));
    request.body = json.encode(roomModel.toJson());
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        return RoomModel.fromJson(decodedData);
      } else {
        print('failed because: ${response.reasonPhrase}');
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return null;
    }
  }

  // Delete
  static Future<void> deleteRoomById(String id) async {
    var request = Request('DELETE', Uri.parse('${baseUrl}rooms/delete/$id'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  /*
  *
  *========================= Query methods =============================*/

  // requesting fetching rooms by hotel id from api
  static Future<List<RoomModel>> getRoomsByHotelId(String hotelId) async {
    print('in api room');
    var request =
        Request('GET', Uri.parse('${baseUrl}rooms/by_hotel/$hotelId'));
    StreamedResponse response = await request.send();
    print('in api room');
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<RoomModel> roomModel = List.generate(
        data.length,
        (index) => RoomModel.fromJson(data[index]),
      );

      print(roomModel);
      return roomModel;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  // fetching room by room id
  static Future<RoomModel?> getRoomByRoomId(String roomId) async {
    var request = Request('GET', Uri.parse('${baseUrl}rooms/$roomId'));
    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);
      RoomModel room = RoomModel.fromJson(data);
      return room;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
  // fetch room by hotel id, status and capacity
  static Future<List<RoomModel>> getRoomsByHotelIdStatusCapacity(String hotelId, String status, num  capacity) async {
    var request = Request('GET', Uri.parse('${baseUrl}rooms/multi/$hotelId/$status/$capacity'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        List<RoomModel> rooms = List.generate(decodedData.length, (index) => RoomModel.fromJson(decodedData[index]),);
      return rooms;
      } else {
        print(response.reasonPhrase);
        throw Error();
      }
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }


}
