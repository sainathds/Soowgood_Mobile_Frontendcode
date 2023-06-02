import 'dart:convert';

List<ProviderScheduleTypeResponse> ProviderScheduleTypeResponseFromJsonList(dynamic str) => List<ProviderScheduleTypeResponse>.from(json.decode(str).map((x) => ProviderScheduleTypeResponse.fromJson(x)));

String ProviderScheduleTypeResponseToJsonList(List<ProviderScheduleTypeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderScheduleTypeResponse {
  String? id;
  String? name;
  String? description;
  String? userTypeId;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  ProviderScheduleTypeResponse({this.id, this.name, this.description, this.userTypeId, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  ProviderScheduleTypeResponse.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.description = json["description"];
    this.userTypeId = json["userTypeId"];
    this.createdBy = json["createdBy"];
    this.createdOn = json["createdOn"];
    this.updatedBy = json["updatedBy"];
    this.updatedOn = json["updatedOn"];
    this.isDeleted = json["isDeleted"];
    this.isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = this.id;
    data["name"] = this.name;
    data["description"] = this.description;
    data["userTypeId"] = this.userTypeId;
    data["createdBy"] = this.createdBy;
    data["createdOn"] = this.createdOn;
    data["updatedBy"] = this.updatedBy;
    data["updatedOn"] = this.updatedOn;
    data["isDeleted"] = this.isDeleted;
    data["isActive"] = this.isActive;
    return data;
  }

  ///*
  ///
  ///
  typeAsString() {
    return '$name';
  }
}