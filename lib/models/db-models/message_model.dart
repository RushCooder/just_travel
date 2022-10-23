import 'package:just_travel/models/db-models/user_model.dart';

class MessageModel {
  MessageModel({
    this.id,
    this.sender,
    this.receiver,
    this.message,
    this.sendDateTime,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.v,
  });


  @override
  String toString() {
    return 'MessageModel{id: $id, sender: $sender, receiver: $receiver, message: $message, sendDateTime: $sendDateTime, images: $images, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }

  MessageModel.fromJson(dynamic json) {
    id = json['_id'];
    sender = json['sender'] != null ? UserModel.fromJson(json['sender']) : null;
    receiver = json['receiver'];
    message = json['message'];
    sendDateTime = json['sendDateTime'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  UserModel? sender;
  String? receiver;
  String? message;
  num? sendDateTime;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  num? v;
  MessageModel copyWith({
    String? id,
    UserModel? sender,
    String? receiver,
    String? message,
    num? sendDateTime,
    List<String>? images,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      MessageModel(
        id: id ?? this.id,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        message: message ?? this.message,
        sendDateTime: sendDateTime ?? this.sendDateTime,
        images: images ?? this.images,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    map['receiver'] = receiver;
    map['message'] = message;
    map['sendDateTime'] = sendDateTime;
    map['images'] = images;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
