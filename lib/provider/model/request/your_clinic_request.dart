class YourClinicRequest {
  String? userId;

  YourClinicRequest({this.userId});

  YourClinicRequest.fromJson(Map<String, dynamic> json) {
    userId = json["UserId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserId"] = userId;
    return _data;
  }
}