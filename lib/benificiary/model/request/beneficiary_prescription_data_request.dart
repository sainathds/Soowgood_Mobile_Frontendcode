
class BeneficiaryPrescriptionDataRequest {
  String? serviceProviderId;
  String? serviceReceiverId;

  BeneficiaryPrescriptionDataRequest({this.serviceProviderId, this.serviceReceiverId});

  BeneficiaryPrescriptionDataRequest.fromJson(Map<String, dynamic> json) {
    serviceProviderId = json["ServiceProviderId"];
    serviceReceiverId = json["ServiceReceiverId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceProviderId"] = serviceProviderId;
    _data["ServiceReceiverId"] = serviceReceiverId;
    return _data;
  }
}