
class BeneficiarySearchProvidersRequest {
  String? appointmentType;
  String? availability;
  int? consultationFees;
  String? dayEndTime;
  String? dayStartingTime;
  String? gender;
  String? location;
  int? pageNumber;
  int? pageSize;
  String? providerSpeciality;
  dynamic providerType;
  String? searchKeyword;
  dynamic serviceType;

  BeneficiarySearchProvidersRequest({this.appointmentType, this.availability, this.consultationFees, this.dayEndTime, this.dayStartingTime, this.gender, this.location, this.pageNumber, this.pageSize, this.providerSpeciality, this.providerType, this.searchKeyword, this.serviceType});

  BeneficiarySearchProvidersRequest.fromJson(Map<String, dynamic> json) {
    appointmentType = json["AppointmentType"];
    availability = json["Availability"];
    consultationFees = json["ConsultationFees"];
    dayEndTime = json["DayEndTime"];
    dayStartingTime = json["DayStartingTime"];
    gender = json["Gender"];
    location = json["Location"];
    pageNumber = json["PageNumber"];
    pageSize = json["PageSize"];
    providerSpeciality = json["ProviderSpeciality"];
    providerType = json["ProviderType"];
    searchKeyword = json["SearchKeyword"];
    serviceType = json["ServiceType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AppointmentType"] = appointmentType;
    _data["Availability"] = availability;
    _data["ConsultationFees"] = consultationFees;
    _data["DayEndTime"] = dayEndTime;
    _data["DayStartingTime"] = dayStartingTime;
    _data["Gender"] = gender;
    _data["Location"] = location;
    _data["PageNumber"] = pageNumber;
    _data["PageSize"] = pageSize;
    _data["ProviderSpeciality"] = providerSpeciality;
    _data["ProviderType"] = providerType;
    _data["SearchKeyword"] = searchKeyword;
    _data["ServiceType"] = serviceType;
    return _data;
  }
}