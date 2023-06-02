class ProviderAddEditPrescriptionRequest {
  String? diognosis;
  String? bookingId;
  String? id;
  String? serviceProviderId;
  String? serviceReceiverId;
  String? prescriptiondate;
  String? prescriptiondurgdetails;
  String? prescriptionmedicaltestdetails;
  String? prescriptionadvicedetails;
  String? file;

  ProviderAddEditPrescriptionRequest({this.diognosis, this.bookingId,this.id, this.serviceProviderId, this.serviceReceiverId, this.prescriptiondate, this.prescriptiondurgdetails, this.prescriptionmedicaltestdetails, this.prescriptionadvicedetails, this.file});

  ProviderAddEditPrescriptionRequest.fromJson(Map<String, dynamic> json) {
    diognosis = json["diognosis"];
    bookingId = json["bookingId"];
    id = json["id"];
    serviceProviderId = json["ServiceProviderId"];
    serviceReceiverId = json["ServiceReceiverId"];
    prescriptiondate = json["prescriptiondate"];
    prescriptiondurgdetails = json["prescriptiondurgdetails"];
    prescriptionmedicaltestdetails = json["prescriptionmedicaltestdetails"];
    prescriptionadvicedetails = json["prescriptionadvicedetails"];
    file = json["File"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["diognosis"] = diognosis;
    _data["bookingId"] = bookingId;
    _data["id"] = id;
    _data["ServiceProviderId"] = serviceProviderId;
    _data["ServiceReceiverId"] = serviceReceiverId;
    _data["prescriptiondate"] = prescriptiondate;
    _data["prescriptiondurgdetails"] = prescriptiondurgdetails;
    _data["prescriptionmedicaltestdetails"] = prescriptionmedicaltestdetails;
    _data["prescriptionadvicedetails"] = prescriptionadvicedetails;
    _data["File"] = file;

    return _data;
  }
}