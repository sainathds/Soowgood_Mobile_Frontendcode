import 'dart:convert';

List<BeneficiaryDrugListResponse> BeneficiaryDrugListResponseFromJsonList(dynamic str) => List<BeneficiaryDrugListResponse>.from(json.decode(str).map((x) => BeneficiaryDrugListResponse.fromJson(x)));

String BeneficiaryDrugListResponseToJsonList(List<BeneficiaryDrugListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeneficiaryDrugListResponse {
  String? durgId;
  String? prescriptionid;
  String? durgname;
  String? weeklyschedule;
  String? timing;
  String? dose;

  BeneficiaryDrugListResponse({this.durgId, this.prescriptionid, this.durgname, this.weeklyschedule, this.timing, this.dose});

  BeneficiaryDrugListResponse.fromJson(Map<String, dynamic> json) {
    durgId = json["durgId"];
    prescriptionid = json["prescriptionid"];
    durgname = json["durgname"];
    weeklyschedule = json["weeklyschedule"];
    timing = json["timing"];
    dose = json["dose"];
  }

  /*static List<BeneficiaryDrugListResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => BeneficiaryDrugListResponse.fromJson(map)).toList();
  }
*/
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["durgId"] = durgId;
    _data["prescriptionid"] = prescriptionid;
    _data["durgname"] = durgname;
    _data["weeklyschedule"] = weeklyschedule;
    _data["timing"] = timing;
    _data["dose"] = dose;
    return _data;
  }
}