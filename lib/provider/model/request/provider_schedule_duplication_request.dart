class ProviderScheduleDuplicationRequest {
  String? appointmentSettingId;
  String? appointmentType;
  String? clinicId;
  String? dayEndingTime;
  String? dayStartingTime;
  String? serviceProviderId;
  String? daysOfWeek;

  ProviderScheduleDuplicationRequest({this.appointmentSettingId, this.appointmentType, this.clinicId, this.dayEndingTime, this.dayStartingTime, this.serviceProviderId, this.daysOfWeek});

  ProviderScheduleDuplicationRequest.fromJson(Map<String, dynamic> json) {
    this.appointmentSettingId = json["AppointmentSettingId"];
    this.appointmentType = json["AppointmentType"];
    this.clinicId = json["ClinicId"];
    this.dayEndingTime = json["DayEndingTime"];
    this.dayStartingTime = json["DayStartingTime"];
    this.serviceProviderId = json["ServiceProviderId"];
    this.daysOfWeek = json["daysOfWeek"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["AppointmentSettingId"] = this.appointmentSettingId;
    data["AppointmentType"] = this.appointmentType;
    data["ClinicId"] = this.clinicId;
    data["DayEndingTime"] = this.dayEndingTime;
    data["DayStartingTime"] = this.dayStartingTime;
    data["ServiceProviderId"] = this.serviceProviderId;
    data["daysOfWeek"] = this.daysOfWeek;
    return data;
  }
}