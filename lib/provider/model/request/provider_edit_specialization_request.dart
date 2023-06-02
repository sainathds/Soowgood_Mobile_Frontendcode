class ProviderEditSpecializationRequest {
  String? userId;
  String? typeId;
  String? specializationName;
  String? serviceName;
  String? id;

  ProviderEditSpecializationRequest({this.userId, this.typeId, this.specializationName, this.serviceName, this.id});

  ProviderEditSpecializationRequest.fromJson(Map<String, dynamic> json) {
    this.userId = json["UserId"];
    this.typeId = json["TypeId"];
    this.specializationName = json["SpecializationName"];
    this.serviceName = json["ServiceName"];
    this.id = json["Id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["UserId"] = this.userId;
    data["TypeId"] = this.typeId;
    data["SpecializationName"] = this.specializationName;
    data["ServiceName"] = this.serviceName;
    data["Id"] = this.id;
    return data;
  }
}