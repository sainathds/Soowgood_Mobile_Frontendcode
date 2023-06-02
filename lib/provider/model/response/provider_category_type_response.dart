import 'dart:convert';

List<ProviderCategoryTypeResponse> ProviderCategoryTypeResponseFromJsonList(dynamic str) => List<ProviderCategoryTypeResponse>.from(json.decode(str).map((x) => ProviderCategoryTypeResponse.fromJson(x)));

String ProviderCategoryTypeResponseToJsonList(List<ProviderCategoryTypeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderCategoryTypeResponse {
  String? id;
  String? provider;
  String? medicalCareType;
  String? providerType;

  ProviderCategoryTypeResponse({this.id, this.provider, this.medicalCareType, this.providerType});

  ProviderCategoryTypeResponse.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.provider = json["provider"];
    this.medicalCareType = json["medicalCareType"];
    this.providerType = json["providerType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["provider"] = this.provider;
    data["medicalCareType"] = this.medicalCareType;
    data["providerType"] = this.providerType;
    return data;
  }

  ///this method will prevent the override of toString
  String categoryAsString() {
    return '${this.provider}';
  }
}