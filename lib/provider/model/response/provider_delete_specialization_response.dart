class ProviderDeleteSpecializationResponse {
  String? id;
  dynamic? typeId;
  dynamic? specializationName;
  dynamic? serviceName;
  dynamic? description;
  String? userId;
  dynamic? createdBy;
  String? createdOn;
  dynamic? updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  ProviderDeleteSpecializationResponse({this.id, this.typeId, this.specializationName, this.serviceName, this.description, this.userId, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  ProviderDeleteSpecializationResponse.fromJson(Map<dynamic, dynamic> json) {
    this.id = json["id"];
    this.typeId = json["typeId"];
    this.specializationName = json["specializationName"];
    this.serviceName = json["serviceName"];
    this.description = json["description"];
    this.userId = json["userId"];
    this.createdBy = json["createdBy"];
    this.createdOn = json["createdOn"];
    this.updatedBy = json["updatedBy"];
    this.updatedOn = json["updatedOn"];
    this.isDeleted = json["isDeleted"];
    this.isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["typeId"] = this.typeId;
    data["specializationName"] = this.specializationName;
    data["serviceName"] = this.serviceName;
    data["description"] = this.description;
    data["userId"] = this.userId;
    data["createdBy"] = this.createdBy;
    data["createdOn"] = this.createdOn;
    data["updatedBy"] = this.updatedBy;
    data["updatedOn"] = this.updatedOn;
    data["isDeleted"] = this.isDeleted;
    data["isActive"] = this.isActive;
    return data;
  }
}