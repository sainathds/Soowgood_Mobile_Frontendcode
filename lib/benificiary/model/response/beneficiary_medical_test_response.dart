import 'dart:convert';

List<BeneficiaryMedicalTestResponse> BeneficiaryMedicalTestResponseFromJsonList(dynamic str) => List<BeneficiaryMedicalTestResponse>.from(json.decode(str).map((x) => BeneficiaryMedicalTestResponse.fromJson(x)));

String BeneficiaryMedicalTestResponseToJsonList(List<BeneficiaryMedicalTestResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeneficiaryMedicalTestResponse {
  String? testid;
  String? prescriptionid;
  String? medicaltest;

  BeneficiaryMedicalTestResponse({this.testid, this.prescriptionid, this.medicaltest});

  BeneficiaryMedicalTestResponse.fromJson(Map<String, dynamic> json) {
    testid = json["testid"];
    prescriptionid = json["prescriptionid"];
    medicaltest = json["medicaltest"];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["testid"] = testid;
    _data["prescriptionid"] = prescriptionid;
    _data["medicaltest"] = medicaltest;
    return _data;
  }
}