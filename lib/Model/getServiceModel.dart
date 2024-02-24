class GetServicesModel {
  String? message;
  Data? data;

  GetServicesModel({this.message, this.data});

  GetServicesModel.fromJson(Map<String, dynamic> json) {
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
  List<GetServices>? services;

  Data({this.services});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <GetServices>[];
      json['services'].forEach((v) {
        services!.add(new GetServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetServices {
  int? id;
  String? name;
  Null? nameBn;
  String? description;
  Null? descriptionBn;
  String? imagePath;

  GetServices(
      {this.id,
        this.name,
        this.nameBn,
        this.description,
        this.descriptionBn,
        this.imagePath});

  GetServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameBn = json['name_bn'];
    description = json['description'];
    descriptionBn = json['description_bn'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_bn'] = this.nameBn;
    data['description'] = this.description;
    data['description_bn'] = this.descriptionBn;
    data['image_path'] = this.imagePath;
    return data;
  }
}