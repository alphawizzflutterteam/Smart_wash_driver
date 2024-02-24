// // To parse this JSON data, do
// //
// //     final getPendingOrderModel = getPendingOrderModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetPendingOrderModel getPendingOrderModelFromJson(String str) => GetPendingOrderModel.fromJson(json.decode(str));
//
// String getPendingOrderModelToJson(GetPendingOrderModel data) => json.encode(data.toJson());
//
// class GetPendingOrderModel {
//   String message;
//   Data data;
//
//   GetPendingOrderModel({
//     required this.message,
//     required this.data,
//   });
//
//   factory GetPendingOrderModel.fromJson(Map<String, dynamic> json) => GetPendingOrderModel(
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   int total;
//   List<dynamic> orders;
//
//   Data({
//     required this.total,
//     required this.orders,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     total: json["total"],
//     orders: List<dynamic>.from(json["orders"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "total": total,
//     "orders": List<dynamic>.from(orders.map((x) => x)),
//   };
// }
// To parse this JSON data, do
//
//     final getPendingOrderModel = getPendingOrderModelFromJson(jsonString);

import 'dart:convert';

GetPendingOrderModel getPendingOrderModelFromJson(String str) => GetPendingOrderModel.fromJson(json.decode(str));

String getPendingOrderModelToJson(GetPendingOrderModel data) => json.encode(data.toJson());

class GetPendingOrderModel {
  String message;
  Data data;

  GetPendingOrderModel({
    required this.message,
    required this.data,
  });

  factory GetPendingOrderModel.fromJson(Map<String, dynamic> json) => GetPendingOrderModel(
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
  int totaldriverOrder;

  Data({
    required this.total,
    required this.totaldriverOrder,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    totaldriverOrder: json["totaldriverOrder"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "totaldriverOrder": totaldriverOrder,
  };
}
