class ProviderDashboardAppointmentsRequest {
  String? serviceProviderId;
  String? bookingtype;

  ProviderDashboardAppointmentsRequest({this.serviceProviderId, this.bookingtype});

  ProviderDashboardAppointmentsRequest.fromJson(Map<String, dynamic> json) {
    serviceProviderId = json["ServiceProviderId"];
    bookingtype = json["bookingtype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceProviderId"] = serviceProviderId;
    _data["bookingtype"] = bookingtype;
    return _data;
  }
}