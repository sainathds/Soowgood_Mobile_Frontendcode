
class ProviderDeleteAwardRequest {
  String? id;
  String? userId;

  ProviderDeleteAwardRequest({this.id, this.userId});

  ProviderDeleteAwardRequest.fromJson(Map<String, dynamic> json) {
    this.id = json["Id"];
    this.userId = json["UserId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Id"] = this.id;
    data["UserId"] = this.userId;
    return data;
  }
}