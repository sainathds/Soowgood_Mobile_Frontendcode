
import 'dart:convert';

List<ProviderScheduleDetailResponse> ProviderScheduleDetailResponseFromJsonList(dynamic str) => List<ProviderScheduleDetailResponse>.from(json.decode(str).map((x) => ProviderScheduleDetailResponse.fromJson(x)));

String ProviderScheduleDetailResponseToJsonList(List<ProviderScheduleDetailResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderScheduleDetailResponse {
  String? appointmentSettingId;
  dynamic dayno;
  dynamic appointmentDayOfWeek;
  String? clinicId;
  String? taskType;
  int? timeSlot;
  String? taskTypeId;
  dynamic appointmentDate;
  int? noOfPatients;
  double? appointmentFees;
  dynamic caldate;
  String? dayStartingTime;
  String? dayEndingTime;
  dynamic appointmentstartime;
  dynamic appointmentendtime;
  dynamic clinicname;
  dynamic cliniccurrentaddress;
  dynamic appointmentEndingDate;
  dynamic appointmentStartingDate;
  dynamic serviceProviderId;
  int? alreadybooked;
  String? appointmentEndingTime;
  String? appointmentStartingTime;
  dynamic appointmentTypeId;
  dynamic mindayname;
  dynamic maxdayname;
  dynamic scheduleType;
  double? paidAmount;
  double? doctorcharges;
  double? admincomission;
  double? patientcharges;
  dynamic appointmentServiceId;
  List<AppointmentDayList>? appointmentDayList;
  List<AppointmentServiceTypeList>? appointmentServiceTypeList;

  ProviderScheduleDetailResponse({this.appointmentSettingId, this.dayno, this.appointmentDayOfWeek, this.clinicId, this.taskType, this.timeSlot, this.taskTypeId, this.appointmentDate, this.noOfPatients, this.appointmentFees, this.caldate, this.dayStartingTime, this.dayEndingTime, this.appointmentstartime, this.appointmentendtime, this.clinicname, this.cliniccurrentaddress, this.appointmentEndingDate, this.appointmentStartingDate, this.serviceProviderId, this.alreadybooked, this.appointmentEndingTime, this.appointmentStartingTime, this.appointmentTypeId, this.mindayname, this.maxdayname, this.scheduleType, this.paidAmount, this.doctorcharges, this.admincomission, this.patientcharges, this.appointmentServiceId, this.appointmentDayList, this.appointmentServiceTypeList});

  ProviderScheduleDetailResponse.fromJson(Map<String, dynamic> json) {
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
    admincomission = json["admincomission"];
    patientcharges = json["patientcharges"];
    appointmentServiceId = json["appointmentServiceId"];
    appointmentDayList = json["appointmentDayList"] == null ? null : (json["appointmentDayList"] as List).map((e) => AppointmentDayList.fromJson(e)).toList();
    appointmentServiceTypeList = json["appointmentServiceTypeList"] == null ? null : (json["appointmentServiceTypeList"] as List).map((e) => AppointmentServiceTypeList.fromJson(e)).toList();
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
    _data["admincomission"] = admincomission;
    _data["patientcharges"] = patientcharges;
    _data["appointmentServiceId"] = appointmentServiceId;
    if(appointmentDayList != null) {
      _data["appointmentDayList"] = appointmentDayList?.map((e) => e.toJson()).toList();
    }
    if(appointmentServiceTypeList != null) {
      _data["appointmentServiceTypeList"] = appointmentServiceTypeList?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class AppointmentServiceTypeList {
  String? appointmentServiceId;
  String? appointmentTypeId;
  String? appointmentSettingId;
  double? appointmentFees;
  bool? isActive;
  String? consultancyType;

  AppointmentServiceTypeList({this.appointmentServiceId, this.appointmentTypeId, this.appointmentSettingId, this.appointmentFees, this.isActive, this.consultancyType});

  AppointmentServiceTypeList.fromJson(Map<String, dynamic> json) {
    appointmentServiceId = json["appointmentServiceId"];
    appointmentTypeId = json["appointmentTypeId"];
    appointmentSettingId = json["appointmentSettingId"];
    appointmentFees = json["appointmentFees"];
    isActive = json["isActive"];
    consultancyType = json["consultancyType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["appointmentServiceId"] = appointmentServiceId;
    _data["appointmentTypeId"] = appointmentTypeId;
    _data["appointmentSettingId"] = appointmentSettingId;
    _data["appointmentFees"] = appointmentFees;
    _data["isActive"] = isActive;
    _data["consultancyType"] = consultancyType;
    return _data;
  }
}

class AppointmentDayList {
  String? appointmentDayId;
  String? appointmentDayOfWeek;
  String? appointmentSettingId;
  bool? isActive;

  AppointmentDayList({this.appointmentDayId, this.appointmentDayOfWeek, this.appointmentSettingId, this.isActive});

  AppointmentDayList.fromJson(Map<String, dynamic> json) {
    appointmentDayId = json["appointmentDayId"];
    appointmentDayOfWeek = json["appointmentDayOfWeek"];
    appointmentSettingId = json["appointmentSettingId"];
    isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["appointmentDayId"] = appointmentDayId;
    _data["appointmentDayOfWeek"] = appointmentDayOfWeek;
    _data["appointmentSettingId"] = appointmentSettingId;
    _data["isActive"] = isActive;
    return _data;
  }
}