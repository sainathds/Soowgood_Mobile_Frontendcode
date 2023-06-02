class TodayBillRequest {
  String? serviceProviderId;

  TodayBillRequest({this.serviceProviderId});

  TodayBillRequest.fromJson(Map<String, dynamic> json) {
    serviceProviderId = json["ServiceProviderId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceProviderId"] = serviceProviderId;
    return _data;
  }
}