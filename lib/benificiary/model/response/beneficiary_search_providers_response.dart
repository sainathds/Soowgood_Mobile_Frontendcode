import 'dart:convert';

List<BeneficiarySearchProvidersResponse> BeneficiarySearchProvidersResponseFromJsonList(dynamic str) => List<BeneficiarySearchProvidersResponse>.from(json.decode(str).map((x) => BeneficiarySearchProvidersResponse.fromJson(x)));

String BeneficiarySearchProvidersResponseToJsonList(List<BeneficiarySearchProvidersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeneficiarySearchProvidersResponse {
  dynamic id;
  String? serviceType;
  String? providerType;
  String? provider;
  String? providerId;
  String? name;
  String? phone;
  String? email;
  String? gender;
  dynamic dayOfWeek;
  dynamic clinicId;
  String? clinicName;
  String? clinicAddress;
  String? specialization;
  dynamic service;
  String? bookNow;
  String? providerImage;
  dynamic availability;
  dynamic consultationFees;
  dynamic dayStartingTime;
  dynamic dayEndingTime;
  int? totalratingpoint;
  int? totalreview;
  String? appointmentType;

  BeneficiarySearchProvidersResponse({this.id, this.serviceType, this.providerType, this.provider, this.providerId, this.name, this.phone, this.email, this.gender, this.dayOfWeek, this.clinicId, this.clinicName, this.clinicAddress, this.specialization, this.service, this.bookNow, this.providerImage, this.availability, this.consultationFees, this.dayStartingTime, this.dayEndingTime, this.totalratingpoint, this.totalreview, this.appointmentType});

  BeneficiarySearchProvidersResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    serviceType = json["serviceType"];
    providerType = json["providerType"];
    provider = json["provider"];
    providerId = json["providerId"];
    name = json["name"];
    phone = json["phone"];
    email = json["email"];
    gender = json["gender"];
    dayOfWeek = json["dayOfWeek"];
    clinicId = json["clinicId"];
    clinicName = json["clinicName"];
    clinicAddress = json["clinicAddress"];
    specialization = json["specialization"];
    service = json["service"];
    bookNow = json["bookNow"];
    providerImage = json["providerImage"];
    availability = json["availability"];
    consultationFees = json["consultationFees"];
    dayStartingTime = json["dayStartingTime"];
    dayEndingTime = json["dayEndingTime"];
    totalratingpoint = json["totalratingpoint"];
    totalreview = json["totalreview"];
    appointmentType = json["appointmentType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["serviceType"] = serviceType;
    _data["providerType"] = providerType;
    _data["provider"] = provider;
    _data["providerId"] = providerId;
    _data["name"] = name;
    _data["phone"] = phone;
    _data["email"] = email;
    _data["gender"] = gender;
    _data["dayOfWeek"] = dayOfWeek;
    _data["clinicId"] = clinicId;
    _data["clinicName"] = clinicName;
    _data["clinicAddress"] = clinicAddress;
    _data["specialization"] = specialization;
    _data["service"] = service;
    _data["bookNow"] = bookNow;
    _data["providerImage"] = providerImage;
    _data["availability"] = availability;
    _data["consultationFees"] = consultationFees;
    _data["dayStartingTime"] = dayStartingTime;
    _data["dayEndingTime"] = dayEndingTime;
    _data["totalratingpoint"] = totalratingpoint;
    _data["totalreview"] = totalreview;
    _data["appointmentType"] = appointmentType;
    return _data;
  }
}