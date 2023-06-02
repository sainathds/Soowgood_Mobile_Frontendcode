class ProviderEditDocumentResponse {
  String? id;
  String? documentname;
  dynamic? documentfilename;
  String? userId;
  dynamic? createdBy;
  String? createdOn;
  dynamic? updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  ProviderEditDocumentResponse({this.id, this.documentname, this.documentfilename, this.userId, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  ProviderEditDocumentResponse.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.documentname = json["documentname"];
    this.documentfilename = json["documentfilename"];
    this.userId = json["userId"];
    this.createdBy = json["createdBy"];
    this.createdOn = json["createdOn"];
    this.updatedBy = json["updatedBy"];
    this.updatedOn = json["updatedOn"];
    this.isDeleted = json["isDeleted"];
    this.isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["documentname"] = this.documentname;
    data["documentfilename"] = this.documentfilename;
    data["userId"] = this.userId;
    data["createdBy"] = this.createdBy;
    data["createdOn"] = this.createdOn;
    data["updatedBy"] = this.updatedBy;
    data["updatedOn"] = this.updatedOn;
    data["isDeleted"] = this.isDeleted;
    data["isActive"] = this.isActive;
    return data;
  }
}