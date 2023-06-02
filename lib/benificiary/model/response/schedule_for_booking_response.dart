
class ScheduleForBookingResponse {
  String? success;
  String? errormsg;
  List<Data>? data;
  List<Cliniclist>? cliniclist;
  List<Appointmentdatedata>? appointmentdatedata;

  ScheduleForBookingResponse({this.success, this.errormsg, this.data, this.cliniclist, this.appointmentdatedata});

  ScheduleForBookingResponse.fromJson(Map<dynamic, dynamic> json) {
    success = json["success"];
    errormsg = json["errormsg"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    cliniclist = json["cliniclist"] == null ? null : (json["cliniclist"] as List).map((e) => Cliniclist.fromJson(e)).toList();
    appointmentdatedata = json["appointmentdatedata"] == null ? null : (json["appointmentdatedata"] as List).map((e) => Appointmentdatedata.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["errormsg"] = errormsg;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    if(cliniclist != null) {
      _data["cliniclist"] = cliniclist?.map((e) => e.toJson()).toList();
    }
    if(appointmentdatedata != null) {
      _data["appointmentdatedata"] = appointmentdatedata?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Appointmentdatedata {
  String? clinicId;
  String? appointmentDayOfWeek;
  String? appointmentDate;
  String? caldate;

  Appointmentdatedata({this.clinicId, this.appointmentDayOfWeek, this.appointmentDate, this.caldate});

  Appointmentdatedata.fromJson(Map<String, dynamic> json) {
    clinicId = json["clinicId"];
    appointmentDayOfWeek = json["appointmentDayOfWeek"];
    appointmentDate = json["appointmentDate"];
    caldate = json["caldate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["clinicId"] = clinicId;
    _data["appointmentDayOfWeek"] = appointmentDayOfWeek;
    _data["appointmentDate"] = appointmentDate;
    _data["caldate"] = caldate;
    return _data;
  }

  ///*
  ///
  ///
  dateAsString() {
    return '$appointmentDate';
  }
}

class Cliniclist {
  String? clinicId;
  String? clinicname;
  String? cliniccurrentaddress;
  String? appointmentStartingDate;
  String? appointmentEndingDate;
  String? serviceProviderId;
  bool? isSelected = false;

  Cliniclist({this.clinicId, this.clinicname, this.cliniccurrentaddress, this.appointmentStartingDate, this.appointmentEndingDate, this.serviceProviderId, this.isSelected});

  Cliniclist.fromJson(Map<String, dynamic> json) {
    clinicId = json["clinicId"];
    clinicname = json["clinicname"];
    cliniccurrentaddress = json["cliniccurrentaddress"];
    appointmentStartingDate = json["appointmentStartingDate"];
    appointmentEndingDate = json["appointmentEndingDate"];
    serviceProviderId = json["serviceProviderId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["clinicId"] = clinicId;
    _data["clinicname"] = clinicname;
    _data["cliniccurrentaddress"] = cliniccurrentaddress;
    _data["appointmentStartingDate"] = appointmentStartingDate;
    _data["appointmentEndingDate"] = appointmentEndingDate;
    _data["serviceProviderId"] = serviceProviderId;
    return _data;
  }
}

class Data {
  String? appointmentSettingId;
  dynamic dayno;
  String? appointmentDayOfWeek;
  String? clinicId;
  dynamic taskType;
  int? timeSlot;
  String? taskTypeId;
  String? appointmentDate;
  int? noOfPatients;
  double? appointmentFees;
  String? caldate;
  String? dayStartingTime;
  String? dayEndingTime;
  String? appointmentstartime;
  String? appointmentendtime;
  String? clinicname;
  String? cliniccurrentaddress;
  String? appointmentEndingDate;
  String? appointmentStartingDate;
  String? serviceProviderId;
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
  String? appointmentServiceId;
  dynamic appointmentDayList;
  dynamic appointmentServiceTypeList;

  Data({this.appointmentSettingId, this.dayno, this.appointmentDayOfWeek, this.clinicId, this.taskType, this.timeSlot, this.taskTypeId, this.appointmentDate, this.noOfPatients, this.appointmentFees, this.caldate, this.dayStartingTime, this.dayEndingTime, this.appointmentstartime, this.appointmentendtime, this.clinicname, this.cliniccurrentaddress, this.appointmentEndingDate, this.appointmentStartingDate, this.serviceProviderId, this.alreadybooked, this.appointmentEndingTime, this.appointmentStartingTime, this.appointmentTypeId, this.mindayname, this.maxdayname, this.scheduleType, this.paidAmount, this.doctorcharges, this.admincomission, this.patientcharges, this.appointmentServiceId, this.appointmentDayList, this.appointmentServiceTypeList});

  Data.fromJson(Map<String, dynamic> json) {
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
    appointmentDayList = json["appointmentDayList"];
    appointmentServiceTypeList = json["appointmentServiceTypeList"];
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
    _data["appointmentDayList"] = appointmentDayList;
    _data["appointmentServiceTypeList"] = appointmentServiceTypeList;
    return _data;
  }


}