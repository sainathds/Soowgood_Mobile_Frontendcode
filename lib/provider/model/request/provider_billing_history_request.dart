
class ProviderBillingHistoryRequest {
  String? appointmentTypeName;
  String? id;
  String? paybackstatus;

  ProviderBillingHistoryRequest({this.appointmentTypeName, this.id, this.paybackstatus});

  ProviderBillingHistoryRequest.fromJson(Map<String, dynamic> json) {
    appointmentTypeName = json["AppointmentTypeName"];
    id = json["Id"];
    paybackstatus = json["paybackstatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AppointmentTypeName"] = appointmentTypeName;
    _data["Id"] = id;
    _data["paybackstatus"] = paybackstatus;
    return _data;
  }
}