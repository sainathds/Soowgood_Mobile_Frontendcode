
class ScheduleForBookingRequest {
  String? serviceProviderId;
  String? appointmentType;

  ScheduleForBookingRequest({this.serviceProviderId, this.appointmentType});

  ScheduleForBookingRequest.fromJson(Map<String, dynamic> json) {
    serviceProviderId = json["ServiceProviderId"];
    appointmentType = json["AppointmentType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceProviderId"] = serviceProviderId;
    _data["AppointmentType"] = appointmentType;
    return _data;
  }
}