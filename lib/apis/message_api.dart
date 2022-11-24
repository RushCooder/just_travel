import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel/models/db-models/message_group_model.dart';
import 'package:just_travel/models/db-models/message_model.dart';
import 'package:just_travel/models/db-models/send_message_model.dart';
import 'package:just_travel/models/db-models/user_model.dart';
import 'package:just_travel/utils/constants/urls.dart';

class MessageApi {
  // create new message
  static Future<bool> createNewMessage(
      SendMessageModel sendMessageModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}message'));
    request.body = json.encode(sendMessageModel);
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
        return true;
      }
      throw response.reasonPhrase.toString();
    } catch (e) {
      print('failed because: $e');
      return false;
    }
  }

  // fetch message group info with message list to api
  static Future<List<MessageGroupModel>> getMessageGroupsByUserId(
      String userId) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}message_group/groups/$userId'));

    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        List<MessageGroupModel> messageGroups = List.generate(
          decodedData.length,
          (index) => MessageGroupModel.fromJson(decodedData[index]),
        );
        return messageGroups;
      }
      throw response.reasonPhrase.toString();

      // throw response.reasonPhrase.toString();
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }

  // fetch all messages with user info by group id
  static Future<List<MessageModel>> getMessagesByGroupId(
      String messageGroupId) async {
    var request = Request(
        'GET', Uri.parse('${baseUrl}message/$messageGroupId'));
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        List<MessageModel> messageGroups = List.generate(
          decodedData.length,
          (index) => MessageModel.fromJson(decodedData[index]),
        );
        return messageGroups;
      }
      throw response.reasonPhrase.toString();
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }

  // fetch all users in group by group id
  static Future<List<UserModel>> fetchUsersByGroupId(
      String messageGroupId) async {
    var request = Request(
        'GET', Uri.parse('${baseUrl}message_group/group/users/$messageGroupId'));
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        List<UserModel> usersInGroup = List.generate(
          decodedData['members'].length,
              (index) => UserModel.fromJson(decodedData['members'][index]),
        );
        return usersInGroup;
      }
      throw response.reasonPhrase.toString();
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }

}
