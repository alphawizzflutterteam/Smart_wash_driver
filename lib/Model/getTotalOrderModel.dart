// To parse this JSON data, do
//
//     final gettotalOrderModel = gettotalOrderModelFromJson(jsonString);

import 'dart:convert';

GettotalOrderModel gettotalOrderModelFromJson(String str) => GettotalOrderModel.fromJson(json.decode(str));

String gettotalOrderModelToJson(GettotalOrderModel data) => json.encode(data.toJson());

class GettotalOrderModel {
  String message;
  Data data;

  GettotalOrderModel({
    required this.message,
    required this.data,
  });

  factory GettotalOrderModel.fromJson(Map<String, dynamic> json) => GettotalOrderModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int total;
  List<dynamic> orders;

  Data({
    required this.total,
    required this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    orders: List<dynamic>.from(json["orders"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "orders": List<dynamic>.from(orders.map((x) => x)),
  };
}
