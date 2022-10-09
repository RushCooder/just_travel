class JoinModel {
  JoinModel({
      this.tripId, 
      this.userId, 
      this.roomId, 
      this.joinDate, 
      this.totalCost, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  JoinModel.fromJson(dynamic json) {
    tripId = json['tripId'];
    userId = json['userId'];
    roomId = json['roomId'];
    joinDate = json['joinDate'];
    totalCost = json['totalCost'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? tripId;
  String? userId;
  String? roomId;
  num? joinDate;
  num? totalCost;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
JoinModel copyWith({  String? tripId,
  String? userId,
  String? roomId,
  num? joinDate,
  num? totalCost,
  String? id,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => JoinModel(  tripId: tripId ?? this.tripId,
  userId: userId ?? this.userId,
  roomId: roomId ?? this.roomId,
  joinDate: joinDate ?? this.joinDate,
  totalCost: totalCost ?? this.totalCost,
  id: id ?? this.id,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tripId'] = tripId;
    map['userId'] = userId;
    map['roomId'] = roomId;
    map['joinDate'] = joinDate;
    map['totalCost'] = totalCost;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}