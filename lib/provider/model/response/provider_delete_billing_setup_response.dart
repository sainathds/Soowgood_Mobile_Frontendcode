
class ProviderDeleteBillingSetupResponse {
  String? id;
  String? bankname;
  String? branchname;
  String? accountname;
  String? accountno;
  String? accounttype;
  String? userId;
  dynamic createdBy;
  String? createdOn;
  dynamic updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  ProviderDeleteBillingSetupResponse({this.id, this.bankname, this.branchname, this.accountname, this.accountno, this.accounttype, this.userId, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  ProviderDeleteBillingSetupResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    bankname = json["bankname"];
    branchname = json["branchname"];
    accountname = json["accountname"];
    accountno = json["accountno"];
    accounttype = json["accounttype"];
    userId = json["userId"];
    createdBy = json["createdBy"];
    createdOn = json["createdOn"];
    updatedBy = json["updatedBy"];
    updatedOn = json["updatedOn"];
    isDeleted = json["isDeleted"];
    isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["bankname"] = bankname;
    _data["branchname"] = branchname;
    _data["accountname"] = accountname;
    _data["accountno"] = accountno;
    _data["accounttype"] = accounttype;
    _data["userId"] = userId;
    _data["createdBy"] = createdBy;
    _data["createdOn"] = createdOn;
    _data["updatedBy"] = updatedBy;
    _data["updatedOn"] = updatedOn;
    _data["isDeleted"] = isDeleted;
    _data["isActive"] = isActive;
    return _data;
  }
}