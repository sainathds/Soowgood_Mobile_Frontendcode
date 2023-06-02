class ProviderMakePaymentResponse {
  String? id;

  ProviderMakePaymentResponse({this.id});

  ProviderMakePaymentResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    return _data;
  }
}