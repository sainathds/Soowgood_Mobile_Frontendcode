class ProviderAddEditPrescriptionResponse {
  String? id;
  String? bookingId;
  String? serviceProviderId;
  String? diognosis;
  String? serviceReceiverId;
  String? prescriptiondate;
  String? signaturename;

  ProviderAddEditPrescriptionResponse({this.id, this.bookingId, this.serviceProviderId, this.diognosis, this.serviceReceiverId, this.prescriptiondate, this.signaturename});

  ProviderAddEditPrescriptionResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    bookingId = json["bookingId"];
    serviceProviderId = json["serviceProviderId"];
    diognosis = json["diognosis"];
    serviceReceiverId = json["serviceReceiverId"];
    prescriptiondate = json["prescriptiondate"];
    signaturename = json["signaturename"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["bookingId"] = bookingId;
    _data["serviceProviderId"] = serviceProviderId;
    _data["diognosis"] = diognosis;
    _data["serviceReceiverId"] = serviceReceiverId;
    _data["prescriptiondate"] = prescriptiondate;
    _data["signaturename"] = signaturename;
    return _data;
  }
}