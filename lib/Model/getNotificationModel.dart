// To parse this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';


GetNotificationModel getNotificationModelFromJson(String str) => GetNotificationModel.fromJson(json.decode(str));

String getNotificationModelToJson(GetNotificationModel data) => json.encode(data.toJson());

class GetNotificationModel {
  String message;
  Data data;

  GetNotificationModel({
    required this.message,
    required this.data,
  });

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<dynamic> notification;

  Data({
    required this.notification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notification: List<dynamic>.from(json["notification"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "notification": List<dynamic>.from(notification.map((x) => x)),
  };
}
