import 'dart:convert';

List<ProviderProfileCompletionCountResponse> ProviderProfileCompletionCountResponseFromJsonList(dynamic str) => List<ProviderProfileCompletionCountResponse>.from(json.decode(str).map((x) => ProviderProfileCompletionCountResponse.fromJson(x)));

String ProviderProfileCompletionCountResponseToJsonList(List<ProviderProfileCompletionCountResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderProfileCompletionCountResponse {
  String? fullName;
  dynamic designation;
  String? gender;
  String? phoneNumber;
  String? email;
  String? address;
  String? serviceName;
  String? specialization;
  String? typeId;
  String? degreeName;
  String? institution;
  String? hospitalName;
  String? hospitalDesignation;
  String? clinicAddress;
  dynamic clinicName;
  String? appointmentSetup;
  String? profileScore;

  ProviderProfileCompletionCountResponse({this.fullName, this.designation, this.gender, this.phoneNumber, this.email, this.address, this.serviceName, this.specialization, this.typeId, this.degreeName, this.institution, this.hospitalName, this.hospitalDesignation, this.clinicAddress, this.clinicName, this.appointmentSetup, this.profileScore});

  ProviderProfileCompletionCountResponse.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    designation = json["designation"];
    gender = json["gender"];
    phoneNumber = json["phoneNumber"];
    email = json["email"];
    address = json["address"];
    serviceName = json["serviceName"];
    specialization = json["specialization"];
    typeId = json["typeId"];
    degreeName = json["degreeName"];
    institution = json["institution"];
    hospitalName = json["hospitalName"];
    hospitalDesignation = json["hospitalDesignation"];
    clinicAddress = json["clinicAddress"];
    clinicName = json["clinicName"];
    appointmentSetup = json["appointmentSetup"];
    profileScore = json["profileScore"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fullName"] = fullName;
    _data["designation"] = designation;
    _data["gender"] = gender;
    _data["phoneNumber"] = phoneNumber;
    _data["email"] = email;
    _data["address"] = address;
    _data["serviceName"] = serviceName;
    _data["specialization"] = specialization;
    _data["typeId"] = typeId;
    _data["degreeName"] = degreeName;
    _data["institution"] = institution;
    _data["hospitalName"] = hospitalName;
    _data["hospitalDesignation"] = hospitalDesignation;
    _data["clinicAddress"] = clinicAddress;
    _data["clinicName"] = clinicName;
    _data["appointmentSetup"] = appointmentSetup;
    _data["profileScore"] = profileScore;
    return _data;
  }
}