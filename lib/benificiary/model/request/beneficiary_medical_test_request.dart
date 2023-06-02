
class BeneficiaryMedicalTestRequest {
  String? id;

  BeneficiaryMedicalTestRequest({this.id});

  BeneficiaryMedicalTestRequest.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
  }

  static List<BeneficiaryMedicalTestRequest> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => BeneficiaryMedicalTestRequest.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    return _data;
  }
}