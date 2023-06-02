import 'dart:convert';

List<BeneficiaryProvidersResponse> BeneficiaryProvidersResponseFromJsonList(dynamic str) => List<BeneficiaryProvidersResponse>.from(json.decode(str).map((x) => BeneficiaryProvidersResponse.fromJson(x)));

String BeneficiaryProvidersResponseToJsonList(List<BeneficiaryProvidersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeneficiaryProvidersResponse {
  dynamic id;
  dynamic serviceType;
  dynamic providerType;
  dynamic provider;
  String? providerId;
  String? name;
  String? phone;
  String? email;
  String? gender;
  dynamic dayOfWeek;
  String? clinicId;
  String? clinicName;
  String? clinicAddress;
  dynamic specialization;
  dynamic service;
  String? bookNow;
  dynamic providerImage;
  dynamic availability;
  dynamic consultationFees;
  dynamic dayStartingTime;
  dynamic dayEndingTime;
  int? totalratingpoint;
  int? totalreview;
  String? appointmentType;

  BeneficiaryProvidersResponse({this.id, this.serviceType, this.providerType, this.provider, this.providerId, this.name, this.phone, this.email, this.gender, this.dayOfWeek, this.clinicId, this.clinicName, this.clinicAddress, this.specialization, this.service, this.bookNow, this.providerImage, this.availability, this.consultationFees, this.dayStartingTime, this.dayEndingTime, this.totalratingpoint, this.totalreview, this.appointmentType});

  BeneficiaryProvidersResponse.fromJson(Map<String, dynamic> json) {
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