
class ProviderBillingSetupRequest {
  String? userId;
  String? accountname;
  String? accountno;
  String? accounttype;
  String? bankname;
  String? branchname;

  ProviderBillingSetupRequest({this.userId, this.accountname, this.accountno, this.accounttype, this.bankname, this.branchname});

  ProviderBillingSetupRequest.fromJson(Map<String, dynamic> json) {
    userId = json["UserId"];
    accountname = json["accountname"];
    accountno = json["accountno"];
    accounttype = json["accounttype"];
    bankname = json["bankname"];
    branchname = json["branchname"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserId"] = userId;
    _data["accountname"] = accountname;
    _data["accountno"] = accountno;
    _data["accounttype"] = accounttype;
    _data["bankname"] = bankname;
    _data["branchname"] = branchname;
    return _data;
  }
}