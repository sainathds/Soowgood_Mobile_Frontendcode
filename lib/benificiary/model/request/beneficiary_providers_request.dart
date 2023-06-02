
class BeneficiaryProvidersRequest {
  String? userRole;

  BeneficiaryProvidersRequest({this.userRole});

  BeneficiaryProvidersRequest.fromJson(Map<String, dynamic> json) {
    userRole = json["UserRole"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserRole"] = userRole;
    return _data;
  }
}