
class ProviderBillInformationRequest {
  String? userId;

  ProviderBillInformationRequest({this.userId});

  ProviderBillInformationRequest.fromJson(Map<String, dynamic> json) {
    userId = json["UserId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserId"] = userId;
    return _data;
  }
}