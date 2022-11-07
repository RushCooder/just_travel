class PaymentModel {
  PaymentModel({
    this.tripId,
    this.userId,
    this.mobileNumber,
    this.tranId,
    this.status,
    this.amount,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  PaymentModel.fromJson(dynamic json) {
    tripId = json['tripId'];
    userId = json['userId'];
    mobileNumber = json['mobileNumber'];
    tranId = json['tranId'];
    status = json['status'];
    amount = json['amount'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? tripId;
  String? userId;
  String? mobileNumber;
  String? tranId;
  String? status;
  num? amount;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
  PaymentModel copyWith({
    String? tripId,
    String? userId,
    String? mobileNumber,
    String? tranId,
    String? status,
    num? amount,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      PaymentModel(
        tripId: tripId ?? this.tripId,
        userId: userId ?? this.userId,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        tranId: tranId ?? this.tranId,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tripId'] = tripId;
    map['userId'] = userId;
    map['mobileNumber'] = mobileNumber;
    map['tranId'] = tranId;
    map['status'] = status;
    map['amount'] = amount;
    return map;
  }
}
