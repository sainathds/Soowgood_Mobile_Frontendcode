
class AppointmentListRequest {
  String? appointmentType;
  String? availability;
  int? consultationFees;
  String? gender;
  String? providerSpeciality;
  String? serviceReceiverId;
  String? serviceType;
  String? bookingtype;
  int? pageSize;
  int? pageNumber;

  AppointmentListRequest({this.appointmentType, this.availability, this.consultationFees, this.gender, this.providerSpeciality, this.serviceReceiverId, this.serviceType, this.bookingtype, this.pageSize, this.pageNumber});

  AppointmentListRequest.fromJson(Map<String, dynamic> json) {
    appointmentType = json["AppointmentType"];
    availability = json["Availability"];
    consultationFees = json["ConsultationFees"];
    gender = json["Gender"];
    providerSpeciality = json["ProviderSpeciality"];
    serviceReceiverId = json["ServiceReceiverId"];
    serviceType = json["ServiceType"];
    bookingtype = json["bookingtype"];
    pageSize = json["PageSize"];
    pageNumber = json["PageNumber"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AppointmentType"] = appointmentType;
    _data["Availability"] = availability;
    _data["ConsultationFees"] = consultationFees;
    _data["Gender"] = gender;
    _data["ProviderSpeciality"] = providerSpeciality;
    _data["ServiceReceiverId"] = serviceReceiverId;
    _data["ServiceType"] = serviceType;
    _data["bookingtype"] = bookingtype;
    _data["PageSize"] = pageSize;
    _data["PageNumber"] = pageNumber;
    return _data;
  }
}