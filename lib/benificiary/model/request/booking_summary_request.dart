class BookingSummaryRequest {
  String? serviceReceiverId;

  BookingSummaryRequest({this.serviceReceiverId});

  BookingSummaryRequest.fromJson(Map<String, dynamic> json) {
    serviceReceiverId = json["ServiceReceiverId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceReceiverId"] = serviceReceiverId;
    return _data;
  }
}