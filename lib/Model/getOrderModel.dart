// To parse this JSON data, do
//
//     final getTodayOrderModel = getTodayOrderModelFromJson(jsonString);

import 'dart:convert';

// GetTodayOrderModel getTodayOrderModelFromJson(String str) => GetTodayOrderModel.fromJson(json.decode(str));
//
// String getTodayOrderModelToJson(GetTodayOrderModel data) => json.encode(data.toJson());

// class GetTodayOrderModel {
//   String message;
//   Data data;
//
//   GetTodayOrderModel({
//     required this.message,
//     required this.data,
//   });
//
//   factory GetTodayOrderModel.fromJson(Map<String, dynamic> json) => GetTodayOrderModel(
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
//   List<Order> orders;
//
//   Data({
//     required this.orders,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
//   };
// }


class GetTodayOrderModel {
  String? message;
  Data? data;

  GetTodayOrderModel({this.message, this.data});

  GetTodayOrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Order>? orders;

  Data({this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Order {
  String id;
  String orderCode;
  String driverStatus;
  List<Driver> drivers;
  Customer customer;
  String discount;
  String amount;
  String totalAmount;
  String deliveryCharge;
  String deliverType;
  String vendorId;
  String orderStatus;
  String orderStatusBn;
  String paymentStatus;
  String paymentStatusBn;
  String paymentType;
  String acceptRejectDriver;
  String paymentTypeBn;
  String pickDate;
  String pickHour;
  String deliveryDate;
  String deliveryHour;
  String orderedAt;
  dynamic rating;
  String item;
  Address address;
  List<Product> products;
  Map<String, String> quantity;
  String payment;
  String paymentUrl;

  Order({
    required this.id,
    required this.orderCode,
    required this.driverStatus,
    required this.drivers,
    required this.customer,
    required this.discount,
    required this.amount,
    required this.totalAmount,
    required this.deliveryCharge,
    required this.deliverType,
    required this.vendorId,
    required this.orderStatus,
    required this.orderStatusBn,
    required this.paymentStatus,
    required this.paymentStatusBn,
    required this.paymentType,
    required this.acceptRejectDriver,
    required this.paymentTypeBn,
    required this.pickDate,
    required this.pickHour,
    required this.deliveryDate,
    required this.deliveryHour,
    required this.orderedAt,
    required this.rating,
    required this.item,
    required this.address,
    required this.products,
    required this.quantity,
    required this.payment,
    required this.paymentUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"].toString(),
    orderCode: json["order_code"].toString(),
    driverStatus: json["driver_status"].toString(),
    drivers: List<Driver>.from(json["drivers"].map((x) => Driver.fromJson(x))),    customer: Customer.fromJson(json["customer"]),
    discount: json["discount"].toString(),
    amount: json["amount"].toString(),
    totalAmount: json["total_amount"].toString(),
    deliveryCharge: json["delivery_charge"].toString(),
    deliverType: json["deliver_type"].toString(),
    vendorId: json["vendor_id"].toString(),
    orderStatus: json["order_status"].toString(),
    orderStatusBn: json["order_status_bn"].toString(),
    paymentStatus: json["payment_status"].toString(),
    paymentStatusBn: json["payment_status_bn"].toString(),
    paymentType: json["payment_type"].toString(),
    acceptRejectDriver: json["accept_reject_driver"].toString(),
    paymentTypeBn: json["payment_type_bn"].toString(),
    pickDate: json["pick_date"].toString(),
    pickHour: json["pick_hour"].toString(),
    deliveryDate: json["delivery_date"].toString(),
    deliveryHour: json["delivery_hour"].toString(),
    orderedAt: json["ordered_at"].toString(),
    rating: json["rating"].toString(),
    item: json["item"].toString(),
    address: Address.fromJson(json["address"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    quantity: Map.from(json["quantity"]).map((k, v) => MapEntry<String, String>(k, v.toString())),
    payment: json["payment"].toString(),
    paymentUrl: json["payment_url"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_code": orderCode,
    "driver_status": driverStatus,
    "drivers": List<dynamic>.from(drivers.map((x) => x.toJson())),
    "customer": customer.toJson(),
    "discount": discount,
    "amount": amount,
    "total_amount": totalAmount,
    "delivery_charge": deliveryCharge,
    "deliver_type": deliverType,
    "vendor_id": vendorId,
    "order_status": orderStatus,
    "order_status_bn": orderStatusBn,
    "payment_status": paymentStatus,
    "payment_status_bn": paymentStatusBn,
    "payment_type": paymentType,
    "accept_reject_driver": acceptRejectDriver,
    "payment_type_bn": paymentTypeBn,
    "pick_date": pickDate,
    "pick_hour": pickHour,
    "delivery_date": deliveryDate,
    "delivery_hour": deliveryHour,
    "ordered_at": orderedAt,
    "rating": rating,
    "item": item,
    "address": address.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "quantity": Map.from(quantity).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "payment": payment,
    "payment_url": paymentUrl,
  };
}

class Address {
  String id;
  String addressName;
  String roadNo;
  String houseNo;
  String houseName;
  String flatNo;
  String block;
  String area;
  String subDistrictId;
  String districtId;
  String addressLine;
  String addressLine2;
  String deliveryNote;
  String postCode;
  String latitude;
  String longitude;

  Address({
    required this.id,
    required this.addressName,
    required this.roadNo,
    required this.houseNo,
    required this.houseName,
    required this.flatNo,
    required this.block,
    required this.area,
    required this.subDistrictId,
    required this.districtId,
    required this.addressLine,
    required this.addressLine2,
    required this.deliveryNote,
    required this.postCode,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"].toString(),
    addressName: json["address_name"].toString(),
    roadNo: json["road_no"].toString(),
    houseNo: json["house_no"].toString(),
    houseName: json["house_name"].toString(),
    flatNo: json["flat_no"].toString(),
    block: json["block"].toString(),
    area: json["area"].toString(),
    subDistrictId: json["sub_district_id"].toString(),
    districtId: json["district_id"].toString(),
    addressLine: json["address_line"].toString(),
    addressLine2: json["address_line2"].toString(),
    deliveryNote: json["delivery_note"].toString(),
    postCode: json["post_code"].toString(),
    latitude: json["latitude"].toString(),
    longitude: json["longitude"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_name": addressName,
    "road_no": roadNo,
    "house_no": houseNo,
    "house_name": houseName,
    "flat_no": flatNo,
    "block": block,
    "area": area,
    "sub_district_id": subDistrictId,
    "district_id": districtId,
    "address_line": addressLine,
    "address_line2": addressLine2,
    "delivery_note": deliveryNote,
    "post_code": postCode,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Customer {
  User user;
  List<Address> addresses;
  String stripeId;

  Customer({
    required this.user,
    required this.addresses,
    required this.stripeId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    user: User.fromJson(json["user"]),
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    stripeId: json["stripe_id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
    "stripe_id": stripeId,
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

class Product {
  String id;
  String name;
  String nameBn;
  String slug;
  String currentPrice;
  String oldPrice;
  String description;
  String imagePath;
  String discountPercentage;
  List<SubProduct> subProducts;
  Service service;
  Variant variant;

  Product({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.slug,
    required this.currentPrice,
    required this.oldPrice,
    required this.description,
    required this.imagePath,
    required this.discountPercentage,
    required this.subProducts,
    required this.service,
    required this.variant,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"].toString(),
    name: json["name"].toString(),
    nameBn: json["name_bn"].toString(),
    slug: json["slug"].toString(),
    currentPrice: json["current_price"].toString(),
    oldPrice: json["old_price"].toString(),
    description: json["description"].toString(),
    imagePath: json["image_path"].toString(),
    discountPercentage: json["discount_percentage"].toString(),
    subProducts: List<SubProduct>.from(json["sub_products"].map((x) => SubProduct.fromJson(x))),
    service: Service.fromJson(json["service"]),
    variant: Variant.fromJson(json["variant"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_bn": nameBn,
    "slug": slug,
    "current_price": currentPrice,
    "old_price": oldPrice,
    "description": description,
    "image_path": imagePath,
    "discount_percentage": discountPercentage,
    "sub_products": List<dynamic>.from(subProducts.map((x) => x.toJson())),
    "service": service.toJson(),
    "variant": variant.toJson(),
  };
}

class Service {
  String id;
  String name;
  String nameBn;
  String description;
  String descriptionBn;
  String imagePath;

  Service({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.description,
    required this.descriptionBn,
    required this.imagePath,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"].toString(),
    name: json["name"].toString(),
    nameBn: json["name_bn"].toString(),
    description: json["description"].toString(),
    descriptionBn: json["description_bn"].toString(),
    imagePath: json["image_path"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_bn": nameBn,
    "description": description,
    "description_bn": descriptionBn,
    "image_path": imagePath,
  };
}

class SubProduct {
  String id;
  String name;
  String price;
  String description;

  SubProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory SubProduct.fromJson(Map<String, dynamic> json) => SubProduct(
    id: json["id"].toString(),
    name: json["name"].toString(),
    price: json["price"].toString(),
    description: json["description"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
  };
}

class Variant {
  String id;
  String name;
  String nameBn;

  Variant({
    required this.id,
    required this.name,
    required this.nameBn,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"].toString(),
    name: json["name"].toString(),
    nameBn: json["name_bn"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_bn": nameBn,
  };
}
class Driver {
  dynamic id;
  dynamic userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic isApprove;

  Driver({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.isApprove,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isApprove: json["is_approve"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_approve": isApprove,
  };
}