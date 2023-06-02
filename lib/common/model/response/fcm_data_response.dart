class FcmDataResponse {
  String? id;
  String? userId;
  String? devicekey;

  FcmDataResponse({this.id, this.userId, this.devicekey});

  FcmDataResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    devicekey = json["devicekey"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["userId"] = userId;
    _data["devicekey"] = devicekey;
    return _data;
  }
}