import 'dart:convert';

List<ProviderSpecializationListResponse> ProviderSpecializationListResponseFromJsonList(dynamic str) => List<ProviderSpecializationListResponse>.from(json.decode(str).map((x) => ProviderSpecializationListResponse.fromJson(x)));

String ProviderSpecializationListResponseToJsonList(List<ProviderSpecializationListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderSpecializationListResponse {
  String? id;
  String? specializationName;
  String? serviceName;
  dynamic? description;
  String? userId;
  dynamic? searchKeyword;
  String? typeId;
  String? type;

  ProviderSpecializationListResponse({this.id, this.specializationName, this.serviceName, this.description, this.userId, this.searchKeyword, this.typeId, this.type});

  ProviderSpecializationListResponse.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.specializationName = json["specializationName"];
    this.serviceName = json["serviceName"];
    this.description = json["description"];
    this.userId = json["userId"];
    this.searchKeyword = json["searchKeyword"];
    this.typeId = json["typeId"];
    this.type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["specializationName"] = this.specializationName;
    data["serviceName"] = this.serviceName;
    data["description"] = this.description;
    data["userId"] = this.userId;
    data["searchKeyword"] = this.searchKeyword;
    data["typeId"] = this.typeId;
    data["type"] = this.type;
    return data;
  }
}