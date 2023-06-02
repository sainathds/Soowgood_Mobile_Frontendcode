
class PaymentProcessRequest {
  String? id;
  String? serviceReceiverId;
  String? paidAmount;
  String? trancurrency;
  String? sourceFrom;

  PaymentProcessRequest({this.id, this.serviceReceiverId, this.paidAmount, this.trancurrency, this.sourceFrom});

  PaymentProcessRequest.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    serviceReceiverId = json["ServiceReceiverId"];
    paidAmount = json["PaidAmount"];
    trancurrency = json["trancurrency"];
    sourceFrom = json["sourcefrom"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["ServiceReceiverId"] = serviceReceiverId;
    _data["PaidAmount"] = paidAmount;
    _data["trancurrency"] = trancurrency;
    _data["sourcefrom"] = sourceFrom;
    return _data;
  }
}