import 'dart:convert';

List<ProviderScheduleListResponse> ProviderScheduleListResponseFromJsonList(dynamic str) => List<ProviderScheduleListResponse>.from(json.decode(str).map((x) => ProviderScheduleListResponse.fromJson(x)));

String ProviderScheduleListResponseToJsonList(List<ProviderScheduleListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ProviderScheduleListResponse {
  String? appointmentSettingId;
  dynamic dayno;
  String? appointmentDayOfWeek;
  String? clinicId;
  dynamic taskType;
  int? timeSlot;
  dynamic taskTypeId;
  dynamic appointmentDate;
  int? noOfPatients;
  double? appointmentFees;
  dynamic caldate;
  String? dayStartingTime;
  String? dayEndingTime;
  dynamic appointmentstartime;
  dynamic appointmentendtime;
  String? clinicname;
  String? cliniccurrentaddress;
  dynamic appointmentEndingDate;
  dynamic appointmentStartingDate;
  dynamic serviceProviderId;
  int? alreadybooked;
  String? appointmentEndingTime;
  String? appointmentStartingTime;
  dynamic appointmentTypeId;
  String? mindayname;
  String? maxdayname;
  String? scheduleType;
  double? paidAmount;
  double? doctorcharges;
  dynamic appointmentServiceId;
  dynamic appointmentDayList;
  dynamic appointmentServiceTypeList;
  double? adminComission;
  double? patientCharges;

  ProviderScheduleListResponse({this.appointmentSettingId, this.dayno, this.appointmentDayOfWeek, this.clinicId, this.taskType, this.timeSlot, this.taskTypeId, this.appointmentDate, this.noOfPatients, this.appointmentFees, this.caldate, this.dayStartingTime, this.dayEndingTime, this.appointmentstartime, this.appointmentendtime, this.clinicname, this.cliniccurrentaddress, this.appointmentEndingDate, this.appointmentStartingDate, this.serviceProviderId, this.alreadybooked, this.appointmentEndingTime, this.appointmentStartingTime, this.appointmentTypeId, this.mindayname, this.maxdayname, this.scheduleType, this.paidAmount, this.doctorcharges, this.appointmentServiceId, this.appointmentDayList, this.appointmentServiceTypeList, this.adminComission, this.patientCharges});

  ProviderScheduleListResponse.fromJson(Map<String, dynamic> json) {
    appointmentSettingId = json["appointmentSettingID"];
    dayno = json["dayno"];
    appointmentDayOfWeek = json["appointmentDayOfWeek"];
    clinicId = json["clinicId"];
    taskType = json["taskType"];
    timeSlot = json["timeSlot"];
    taskTypeId = json["taskTypeId"];
    appointmentDate = json["appointmentDate"];
    noOfPatients = json["noOfPatients"];
    appointmentFees = json["appointmentFees"];
    caldate = json["caldate"];
    dayStartingTime = json["dayStartingTime"];
    dayEndingTime = json["dayEndingTime"];
    appointmentstartime = json["appointmentstartime"];
    appointmentendtime = json["appointmentendtime"];
    clinicname = json["clinicname"];
    cliniccurrentaddress = json["cliniccurrentaddress"];
    appointmentEndingDate = json["appointmentEndingDate"];
    appointmentStartingDate = json["appointmentStartingDate"];
    serviceProviderId = json["serviceProviderId"];
    alreadybooked = json["alreadybooked"];
    appointmentEndingTime = json["appointmentEndingTime"];
    appointmentStartingTime = json["appointmentStartingTime"];
    appointmentTypeId = json["appointmentTypeId"];
    mindayname = json["mindayname"];
    maxdayname = json["maxdayname"];
    scheduleType = json["scheduleType"];
    paidAmount = json["paidAmount"];
    doctorcharges = json["doctorcharges"];
    appointmentServiceId = json["appointmentServiceId"];
    appointmentDayList = json["appointmentDayList"];
    appointmentServiceTypeList = json["appointmentServiceTypeList"];
    adminComission = json["admincomission"];
    patientCharges = json["patientcharges"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["appointmentSettingID"] = appointmentSettingId;
    _data["dayno"] = dayno;
    _data["appointmentDayOfWeek"] = appointmentDayOfWeek;
    _data["clinicId"] = clinicId;
    _data["taskType"] = taskType;
    _data["timeSlot"] = timeSlot;
    _data["taskTypeId"] = taskTypeId;
    _data["appointmentDate"] = appointmentDate;
    _data["noOfPatients"] = noOfPatients;
    _data["appointmentFees"] = appointmentFees;
    _data["caldate"] = caldate;
    _data["dayStartingTime"] = dayStartingTime;
    _data["dayEndingTime"] = dayEndingTime;
    _data["appointmentstartime"] = appointmentstartime;
    _data["appointmentendtime"] = appointmentendtime;
    _data["clinicname"] = clinicname;
    _data["cliniccurrentaddress"] = cliniccurrentaddress;
    _data["appointmentEndingDate"] = appointmentEndingDate;
    _data["appointmentStartingDate"] = appointmentStartingDate;
    _data["serviceProviderId"] = serviceProviderId;
    _data["alreadybooked"] = alreadybooked;
    _data["appointmentEndingTime"] = appointmentEndingTime;
    _data["appointmentStartingTime"] = appointmentStartingTime;
    _data["appointmentTypeId"] = appointmentTypeId;
    _data["mindayname"] = mindayname;
    _data["maxdayname"] = maxdayname;
    _data["scheduleType"] = scheduleType;
    _data["paidAmount"] = paidAmount;
    _data["doctorcharges"] = doctorcharges;
    _data["appointmentServiceId"] = appointmentServiceId;
    _data["appointmentDayList"] = appointmentDayList;
    _data["appointmentServiceTypeList"] = appointmentServiceTypeList;
    _data["admincomission"] = adminComission;
    _data["patientcharges"] = patientCharges;

    return _data;
  }
}