class ProviderDeleteSpecializationRequest {
  String? userId;
  String? id;

  ProviderDeleteSpecializationRequest({this.userId, this.id});

  ProviderDeleteSpecializationRequest.fromJson(Map<String, dynamic> json) {
    this.userId = json["UserId"];
    this.id = json["Id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["UserId"] = this.userId;
    data["Id"] = this.id;
    return data;
  }
}