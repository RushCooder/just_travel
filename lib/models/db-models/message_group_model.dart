class MessageGroupModel {
  MessageGroupModel({
      this.id, 
      this.groupName, 
      this.trip, 
      this.members, 
      this.messages, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  MessageGroupModel.fromJson(dynamic json) {
    id = json['_id'];
    groupName = json['groupName'];
    trip = json['trip'];
    members = json['members'] != null ? json['members'].cast<String>() : [];
    messages = json['messages'] != null ? json['messages'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? groupName;
  String? trip;
  List<String>? members;
  List<String>? messages;
  String? createdAt;
  String? updatedAt;
  num? v;
MessageGroupModel copyWith({  String? id,
  String? groupName,
  String? trip,
  List<String>? members,
  List<String>? messages,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => MessageGroupModel(  id: id ?? this.id,
  groupName: groupName ?? this.groupName,
  trip: trip ?? this.trip,
  members: members ?? this.members,
  messages: messages ?? this.messages,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['groupName'] = groupName;
    map['trip'] = trip;
    map['members'] = members;
    map['messages'] = messages;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}