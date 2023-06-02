class PaymentProcessResponse {
  String? id;
  String? trandate;
  String? transstatus;
  dynamic transno;
  String? refno;
  String? trancurrency;
  dynamic failureremark;
  dynamic refundRefid;
  String? refunddate;
  dynamic refundstatus;

  PaymentProcessResponse({this.id, this.trandate, this.transstatus, this.transno, this.refno, this.trancurrency, this.failureremark, this.refundRefid, this.refunddate, this.refundstatus});

  PaymentProcessResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    trandate = json["trandate"];
    transstatus = json["transstatus"];
    transno = json["transno"];
    refno = json["refno"];
    trancurrency = json["trancurrency"];
    failureremark = json["failureremark"];
    refundRefid = json["refund_refid"];
    refunddate = json["refunddate"];
    refundstatus = json["refundstatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["trandate"] = trandate;
    _data["transstatus"] = transstatus;
    _data["transno"] = transno;
    _data["refno"] = refno;
    _data["trancurrency"] = trancurrency;
    _data["failureremark"] = failureremark;
    _data["refund_refid"] = refundRefid;
    _data["refunddate"] = refunddate;
    _data["refundstatus"] = refundstatus;
    return _data;
  }
}