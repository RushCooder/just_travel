class UserModel {
  UserModel({
    this.name,
    this.email,
    this.mobile,
    this.city,
    this.division,
    this.profileImage,
    this.coverImage,
    this.uploadImages,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });


  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, mobile: $mobile, city: $city, division: $division, profileImage: $profileImage, coverImage: $coverImage, uploadImages: $uploadImages, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }

  UserModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'] != null ? Email.fromJson(json['email']) : null;
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    city = json['city'];
    division = json['division'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    uploadImages =
        json['uploadImages'] != null ? json['uploadImages'].cast<String>() : [];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? name;
  Email? email;
  Mobile? mobile;
  String? city;
  String? division;
  String? profileImage;
  String? coverImage;
  List<String>? uploadImages;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;
  UserModel copyWith({
    String? name,
    Email? email,
    Mobile? mobile,
    String? city,
    String? division,
    String? profileImage,
    String? coverImage,
    List<String>? uploadImages,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        city: city ?? this.city,
        division: division ?? this.division,
        profileImage: profileImage ?? this.profileImage,
        coverImage: coverImage ?? this.coverImage,
        uploadImages: uploadImages ?? this.uploadImages,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (email != null) {
      map['email'] = email?.toJson();
    }
    if (mobile != null) {
      map['mobile'] = mobile?.toJson();
    }
    map['city'] = city;
    map['division'] = division;
    map['profileImage'] = profileImage;
    map['coverImage'] = coverImage;
    map['uploadImages'] = uploadImages;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class Mobile {
  Mobile({
    this.number,
    this.isVerified,
  });


  @override
  String toString() {
    return 'Mobile{number: $number, isVerified: $isVerified}';
  }

  Mobile.fromJson(dynamic json) {
    number = json['number'];
    isVerified = json['isVerified'];
  }
  String? number;
  bool? isVerified;
  Mobile copyWith({
    String? number,
    bool? isVerified,
  }) =>
      Mobile(
        number: number ?? this.number,
        isVerified: isVerified ?? this.isVerified,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['isVerified'] = isVerified;
    return map;
  }
}

class Email {
  Email({
    this.emailId,
    this.isVerified,
  });


  @override
  String toString() {
    return 'Email{emailId: $emailId, isVerified: $isVerified}';
  }

  Email.fromJson(dynamic json) {
    emailId = json['emailId'];
    isVerified = json['isVerified'];
  }
  String? emailId;
  bool? isVerified;
  Email copyWith({
    String? emailId,
    bool? isVerified,
  }) =>
      Email(
        emailId: emailId ?? this.emailId,
        isVerified: isVerified ?? this.isVerified,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emailId'] = emailId;
    map['isVerified'] = isVerified;
    return map;
  }
}
