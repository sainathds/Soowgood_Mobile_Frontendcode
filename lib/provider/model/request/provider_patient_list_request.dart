
class ProviderPatientListRequest {
  String? id;

  ProviderPatientListRequest({this.id});

  ProviderPatientListRequest.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    return _data;
  }
}