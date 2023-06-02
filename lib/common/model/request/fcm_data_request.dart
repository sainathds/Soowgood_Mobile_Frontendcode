class FcmDataRequest {
  String? userId;
  String? devicekey;

  FcmDataRequest({this.userId, this.devicekey});

  FcmDataRequest.fromJson(Map<String, dynamic> json) {
    userId = json["UserID"];
    devicekey = json["devicekey"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserID"] = userId;
    _data["devicekey"] = devicekey;
    return _data;
  }
}