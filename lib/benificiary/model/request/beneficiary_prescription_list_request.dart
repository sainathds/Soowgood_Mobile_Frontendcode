
class BeneficiaryPrescriptionListRequest {
  String? serviceReceiverId;
  String? serviceProviderId;

  BeneficiaryPrescriptionListRequest({this.serviceReceiverId, this.serviceProviderId});

  BeneficiaryPrescriptionListRequest.fromJson(Map<String, dynamic> json) {
    serviceReceiverId = json["ServiceReceiverId"];
    serviceProviderId = json["ServiceProviderId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceReceiverId"] = serviceReceiverId;
    _data["ServiceProviderId"] = serviceProviderId;
    return _data;
  }
}