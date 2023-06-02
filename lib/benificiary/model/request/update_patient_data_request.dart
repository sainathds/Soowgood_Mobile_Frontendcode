class UpdatePatientDataRequest {
  String? id;
  String? patientAddress;
  String? patientName;

  UpdatePatientDataRequest({this.id, this.patientAddress, this.patientName});

  UpdatePatientDataRequest.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    patientAddress = json["patientAddress"];
    patientName = json["patientName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Id"] = id;
    _data["patientAddress"] = patientAddress;
    _data["patientName"] = patientName;
    return _data;
  }
}