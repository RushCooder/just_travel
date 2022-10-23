import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_travel/apis/message_api.dart';
import 'package:just_travel/models/db-models/message_group_model.dart';
import 'package:just_travel/models/db-models/message_model.dart';
import 'package:just_travel/models/db-models/send_message_model.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageGroupModel> messageGroupList = [];
  List<MessageModel> messageList = [];

  Timer? _timer;

  void autoRefresh(String groupId) {
    int x = 0;
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      getAllMessagesByGroupId(groupId);
      print('called: $x times');
    });
  }

  Future<bool> cancelAutoRefresh() async {
    if (_timer != null) {
      _timer!.cancel();
      print('auto refresh off');
      return true;
    }
    print('auto refresh on');
    return false;
  }

  // creating new message
  Future<bool> createNewMessage(
      String message, String sender, String receiver) async {
    DateTime date = DateTime.now();
    SendMessageModel sendMessageModel = SendMessageModel(
      sender: sender,
      receiver: receiver,
      sendDateTime: date.millisecondsSinceEpoch,
      message: message,
    );

    try {
      bool isCreated = await MessageApi.createNewMessage(sendMessageModel);
      if (isCreated) {
        getAllMessagesByGroupId(receiver);
        return true;
      }

      throw 'Message Creation failed';
    } catch (error) {
      rethrow;
    }
  }

  // fetch all groups by use id
  getMessageGroupsByUserId(String userId) async {
    messageGroupList = await MessageApi.getMessageGroupsByUserId(userId);
    notifyListeners();
  }

  // fetching all messages by group id
  getAllMessagesByGroupId(String groupId) async {
    messageList = await MessageApi.getMessagesByGroupId(groupId);
    notifyListeners();
  }
}
