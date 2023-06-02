class ProviderCancelAppointmentRequest {
  String? appointmentSettingId;
  String? beneficiaryComment;
  String? id;
  bool? isBookingCancelledByReceiver;
  String? serviceProviderId;
  String? serviceReceiverId;

  ProviderCancelAppointmentRequest({this.appointmentSettingId, this.beneficiaryComment, this.id, this.isBookingCancelledByReceiver, this.serviceProviderId, this.serviceReceiverId});

  ProviderCancelAppointmentRequest.fromJson(Map<String, dynamic> json) {
    appointmentSettingId = json["AppointmentSettingId"];
    beneficiaryComment = json["BeneficiaryComment"];
    id = json["Id"];
    isBookingCancelledByReceiver = json["IsBookingCancelledByReceiver"];
    serviceProviderId = json["ServiceProviderId"];
    serviceReceiverId = json["ServiceReceiverId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AppointmentSettingId"] = appointmentSettingId;
    _data["BeneficiaryComment"] = beneficiaryComment;
    _data["Id"] = id;
    _data["IsBookingCancelledByReceiver"] = isBookingCancelledByReceiver;
    _data["ServiceProviderId"] = serviceProviderId;
    _data["ServiceReceiverId"] = serviceReceiverId;
    return _data;
  }
}