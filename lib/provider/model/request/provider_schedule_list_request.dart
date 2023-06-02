class ProviderScheduleListRequest {
  String? appointmentType;
  String? serviceProviderId;

  ProviderScheduleListRequest({this.appointmentType, this.serviceProviderId});

  ProviderScheduleListRequest.fromJson(Map<String, dynamic> json) {
    appointmentType = json["AppointmentType"];
    serviceProviderId = json["ServiceProviderId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AppointmentType"] = appointmentType;
    _data["ServiceProviderId"] = serviceProviderId;
    return _data;
  }
}