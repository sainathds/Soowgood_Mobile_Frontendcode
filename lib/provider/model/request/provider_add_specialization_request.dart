class ProviderAddSpecializationRequest {
  String? userId;
  String? typeId;
  String? specializationName;
  String? serviceName;

  ProviderAddSpecializationRequest({this.userId, this.typeId, this.specializationName, this.serviceName});

  ProviderAddSpecializationRequest.fromJson(Map<String, dynamic> json) {
    this.userId = json["UserId"];
    this.typeId = json["TypeId"];
    this.specializationName = json["SpecializationName"];
    this.serviceName = json["ServiceName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["UserId"] = this.userId;
    data["TypeId"] = this.typeId;
    data["SpecializationName"] = this.specializationName;
    data["ServiceName"] = this.serviceName;
    return data;
  }
}