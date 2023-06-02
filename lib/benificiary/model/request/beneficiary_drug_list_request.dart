class BeneficiaryDrugListRequest {
  String? id;

  BeneficiaryDrugListRequest({this.id});

  BeneficiaryDrugListRequest.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    return _data;
  }
}