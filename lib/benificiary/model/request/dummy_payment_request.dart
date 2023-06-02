
class DummyPaymentRequest {
  String? tranpkid;
  String? bankTranId;
  String? statuscode;
  String? errormessage;

  DummyPaymentRequest({this.tranpkid, this.bankTranId, this.statuscode, this.errormessage});

  DummyPaymentRequest.fromJson(Map<String, dynamic> json) {
    tranpkid = json["tranpkid"];
    bankTranId = json["bank_tran_id"];
    statuscode = json["statuscode"];
    errormessage = json["errormessage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["tranpkid"] = tranpkid;
    _data["bank_tran_id"] = bankTranId;
    _data["statuscode"] = statuscode;
    _data["errormessage"] = errormessage;
    return _data;
  }
}