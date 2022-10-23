class SendMessageModel {
  SendMessageModel({
    this.sender,
    this.receiver,
    this.message,
    this.sendDateTime,
    this.images,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });


  @override
  String toString() {
    return 'SendMessageModel{sender: $sender, receiver: $receiver, message: $message, sendDateTime: $sendDateTime, images: $images, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }

  SendMessageModel.fromJson(dynamic json) {
    sender = json['sender'];
    receiver = json['receiver'];
    message = json['message'];
    sendDateTime = json['sendDateTime'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? sender;
  String? receiver;
  String? message;
  num? sendDateTime;
  List<String>? images;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
  SendMessageModel copyWith({
    String? sender,
    String? receiver,
    String? message,
    num? sendDateTime,
    List<String>? images,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      SendMessageModel(
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        message: message ?? this.message,
        sendDateTime: sendDateTime ?? this.sendDateTime,
        images: images ?? this.images,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender'] = sender;
    map['receiver'] = receiver;
    map['message'] = message;
    map['sendDateTime'] = sendDateTime;
    map['images'] = images;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
