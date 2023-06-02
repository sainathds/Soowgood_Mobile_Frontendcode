class ProviderAppointmentListRequest {
  String? appointmentTypeId;
  String? clinicId;
  String? schedule;
  String? serviceProviderId;

  ProviderAppointmentListRequest({this.appointmentTypeId, this.clinicId, this.schedule, this.serviceProviderId});

  ProviderAppointmentListRequest.fromJson(Map<String, dynamic> json) {
    appointmentTypeId = json["AppointmentTypeId"];
    clinicId = json["ClinicId"];
    schedule = json["Schedule"];
    serviceProviderId = json["ServiceProviderId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AppointmentTypeId"] = appointmentTypeId;
    _data["ClinicId"] = clinicId;
    _data["Schedule"] = schedule;
    _data["ServiceProviderId"] = serviceProviderId;
    return _data;
  }
}