class RequestTripModel {
  RequestTripModel({
      this.userId, 
      this.placeName, 
      this.description, 
      this.district,
      this.division, 
      this.startDate, 
      this.endDate, 
      this.photos, 
      this.status, 
      this.travellers, 
      this.hotel, 
      this.room, 
      this.totalCost, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});


  @override
  String toString() {
    return 'RequestTripModel{userId: $userId, placeName: $placeName, description: $description, district: $district, division: $division, startDate: $startDate, endDate: $endDate, photos: $photos, status: $status, travellers: $travellers, hotel: $hotel, room: $room, totalCost: $totalCost, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }

  RequestTripModel.fromJson(dynamic json) {
    userId = json['userId'];
    placeName = json['placeName'];
    description = json['description'];
    district = json['district'];
    division = json['division'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    status = json['status'];
    travellers = json['travellers'];
    hotel = json['hotel'];
    room = json['room'];
    totalCost = json['totalCost'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? userId;
  String? placeName;
  String? description;
  String? district;
  String? division;
  num? startDate;
  num? endDate;
  List<String>? photos;
  String? status;
  num? travellers;
  String? hotel;
  String? room;
  num? totalCost;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
RequestTripModel copyWith({  String? userId,
  String? placeName,
  String? description,
  String? district,
  String? division,
  num? startDate,
  num? endDate,
  List<String>? photos,
  String? status,
  num? travellers,
  String? hotel,
  String? room,
  num? totalCost,
  String? id,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => RequestTripModel(  userId: userId ?? this.userId,
  placeName: placeName ?? this.placeName,
  description: description ?? this.description,
  district: district ?? this.district,
  division: division ?? this.division,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  photos: photos ?? this.photos,
  status: status ?? this.status,
  travellers: travellers ?? this.travellers,
  hotel: hotel ?? this.hotel,
  room: room ?? this.room,
  totalCost: totalCost ?? this.totalCost,
  id: id ?? this.id,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['placeName'] = placeName;
    map['description'] = description;
    map['district'] = district;
    map['division'] = division;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['photos'] = photos;
    map['status'] = status;
    map['travellers'] = travellers;
    map['hotel'] = hotel;
    map['room'] = room;
    map['totalCost'] = totalCost;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}