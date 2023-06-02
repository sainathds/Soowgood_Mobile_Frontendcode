
class BeneficiaryAddEditBookingRequest {
  String? appointmentSettingId;
  String? dayofWeek;
  dynamic id;
  String? serviceProviderId;
  String? serviceReceiverId;
  String? tentativeDate;
  String? appointmentServiceId;
  String? appointmentamt;
  String? doctorcharges;
  String? paidAmount;
  String? scheduleEndTime;
  String? scheduleStartTime;

  BeneficiaryAddEditBookingRequest({this.appointmentSettingId, this.dayofWeek, this.id, this.serviceProviderId, this.serviceReceiverId, this.tentativeDate, this.appointmentServiceId, this.appointmentamt, this.doctorcharges, this.paidAmount, this.scheduleEndTime, this.scheduleStartTime});

  BeneficiaryAddEditBookingRequest.fromJson(Map<String, dynamic> json) {
    appointmentSettingId = json["AppointmentSettingId"];
    dayofWeek = json["DayofWeek"];
    id = json["Id"];
    serviceProviderId = json["ServiceProviderId"];
    serviceReceiverId = json["ServiceReceiverId"];
    tentativeDate = json["TentativeDate"];
    appointmentServiceId = json["appointmentServiceId"];
    appointmentamt = json["appointmentamt"];
    doctorcharges = json["doctorcharges"];
    paidAmount = json["paidAmount"];
    scheduleEndTime = json["scheduleEndTime"];
    scheduleStartTime = json["scheduleStartTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AppointmentSettingId"] = appointmentSettingId;
    _data["DayofWeek"] = dayofWeek;
    _data["Id"] = id;
    _data["ServiceProviderId"] = serviceProviderId;
    _data["ServiceReceiverId"] = serviceReceiverId;
    _data["TentativeDate"] = tentativeDate;
    _data["appointmentServiceId"] = appointmentServiceId;
    _data["appointmentamt"] = appointmentamt;
    _data["doctorcharges"] = doctorcharges;
    _data["paidAmount"] = paidAmount;
    _data["scheduleEndTime"] = scheduleEndTime;
    _data["scheduleStartTime"] = scheduleStartTime;
    return _data;
  }
}