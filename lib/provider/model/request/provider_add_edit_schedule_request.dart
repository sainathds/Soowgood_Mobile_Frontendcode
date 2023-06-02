class ProviderAddEditScheduleRequest {
  String? appointmentSettingId;
  String? appointmentType;
  String? clinicId;
  String? dayEndingTime;
  String? dayStartingTime;
  String? noOfPatients;
  String? serviceProviderId;
  String? taskTypeId;
  String? timeSlot;
  String? daysOfWeek;

  ProviderAddEditScheduleRequest({this.appointmentSettingId, this.appointmentType, this.clinicId, this.dayEndingTime, this.dayStartingTime, this.noOfPatients, this.serviceProviderId, this.taskTypeId, this.timeSlot, this.daysOfWeek});

  ProviderAddEditScheduleRequest.fromJson(Map<String, dynamic> json) {
    this.appointmentSettingId = json["AppointmentSettingId"];
    this.appointmentType = json["AppointmentType"];
    this.clinicId = json["ClinicId"];
    this.dayEndingTime = json["DayEndingTime"];
    this.dayStartingTime = json["DayStartingTime"];
    this.noOfPatients = json["NoOfPatients"];
    this.serviceProviderId = json["ServiceProviderId"];
    this.taskTypeId = json["TaskTypeId"];
    this.timeSlot = json["TimeSlot"];
    this.daysOfWeek = json["daysOfWeek"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["AppointmentSettingId"] = this.appointmentSettingId;
    data["AppointmentType"] = this.appointmentType;
    data["ClinicId"] = this.clinicId;
    data["DayEndingTime"] = this.dayEndingTime;
    data["DayStartingTime"] = this.dayStartingTime;
    data["NoOfPatients"] = this.noOfPatients;
    data["ServiceProviderId"] = this.serviceProviderId;
    data["TaskTypeId"] = this.taskTypeId;
    data["TimeSlot"] = this.timeSlot;
    data["daysOfWeek"] = this.daysOfWeek;
    return data;
  }
}