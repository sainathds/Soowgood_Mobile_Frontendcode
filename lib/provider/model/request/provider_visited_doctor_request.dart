class ProviderVisitedDoctorListRequest {
  String? serviceProviderId;
  String? serviceReceiverId;

  ProviderVisitedDoctorListRequest({this.serviceProviderId, this.serviceReceiverId});

  ProviderVisitedDoctorListRequest.fromJson(Map<String, dynamic> json) {
    serviceProviderId = json["ServiceProviderId"];
    serviceReceiverId = json["ServiceReceiverId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceProviderId"] = serviceProviderId;
    _data["ServiceReceiverId"] = serviceReceiverId;
    return _data;
  }
}