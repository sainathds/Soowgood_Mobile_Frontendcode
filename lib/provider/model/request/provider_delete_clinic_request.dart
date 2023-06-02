
class ProviderDeleteClinicRequest {
  String? id;

  ProviderDeleteClinicRequest({this.id});

  ProviderDeleteClinicRequest.fromJson(Map<String, dynamic> json) {
    this.id = json["Id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Id"] = this.id;
    return data;
  }
}