class DoctorsCountRequest {
  String? serviceReceiverId;

  DoctorsCountRequest({this.serviceReceiverId});

  DoctorsCountRequest.fromJson(Map<String, dynamic> json) {
    serviceReceiverId = json["ServiceReceiverId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceReceiverId"] = serviceReceiverId;
    return _data;
  }
}