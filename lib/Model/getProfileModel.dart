// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);



class GetProfileModel {
  String message;
  Data data;

  GetProfileModel({
    required this.message,
    required this.data,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  User user;

  Data({
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  String id;
  String firstName;
  String lastName;
  String name;
  String email;
  String mobile;
  String gender;
  List<dynamic> services;
  String serviceP;
  String address;
  DateTime mobileVerifiedAt;
  String isActive;
  String alternativePhone;
  String profilePhotoPath;
  String drivingLience;
  String dateOfBirth;
  String joinDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.services,
    required this.serviceP,
    required this.address,
    required this.mobileVerifiedAt,
    required this.isActive,
    required this.alternativePhone,
    required this.profilePhotoPath,
    required this.drivingLience,
    required this.dateOfBirth,
    required this.joinDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"].toString(),
    firstName: json["first_name"].toString(),
    lastName: json["last_name"].toString(),
    name: json["name"].toString(),
    email: json["email"].toString(),
    mobile: json["mobile"].toString(),
    gender: json["gender"].toString(),
    services: List<dynamic>.from(json["services"].map((x) => x)),
    serviceP: json["service_p"].toString(),
    address: json["address"].toString(),
    mobileVerifiedAt: DateTime.parse(json["mobile_verified_at"]),
    isActive: json["is_active"].toString(),
    alternativePhone: json["alternative_phone"].toString(),
    profilePhotoPath: json["profile_photo_path"].toString(),
    drivingLience: json["driving_lience"].toString(),
    dateOfBirth: json["date_of_birth"].toString(),
    joinDate: json["join_date"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "name": name,
    "email": email,
    "mobile": mobile,
    "gender": gender,
    "services": List<dynamic>.from(services.map((x) => x)),
    "service_p": serviceP,
    "address": address,
    "mobile_verified_at": mobileVerifiedAt.toIso8601String(),
    "is_active": isActive,
    "alternative_phone": alternativePhone,
    "profile_photo_path": profilePhotoPath,
    "driving_lience": drivingLience,
    "date_of_birth": dateOfBirth,
    "join_date": joinDate,
  };
}
