import 'dart:convert';

List<BeneficiaryAdviceListResponse> BeneficiaryAdviceListResponseFromJsonList(dynamic str) => List<BeneficiaryAdviceListResponse>.from(json.decode(str).map((x) => BeneficiaryAdviceListResponse.fromJson(x)));

String BeneficiaryAdviceListResponseToJsonList(List<BeneficiaryAdviceListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeneficiaryAdviceListResponse {
  String? adviceid;
  String? prescriptionid;
  String? advice;

  BeneficiaryAdviceListResponse({this.adviceid, this.prescriptionid, this.advice});

  BeneficiaryAdviceListResponse.fromJson(Map<String, dynamic> json) {
    adviceid = json["adviceid"];
    prescriptionid = json["prescriptionid"];
    advice = json["advice"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["adviceid"] = adviceid;
    _data["prescriptionid"] = prescriptionid;
    _data["advice"] = advice;
    return _data;
  }
}