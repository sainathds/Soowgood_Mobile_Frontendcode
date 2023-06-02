class ProviderSpecializationListRequest {
  String? userId;

  ProviderSpecializationListRequest({this.userId});

  ProviderSpecializationListRequest.fromJson(Map<String, dynamic> json) {
    this.userId = json["UserId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["UserId"] = this.userId;
    return data;
  }
}