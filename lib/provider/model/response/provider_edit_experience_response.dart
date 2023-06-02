class ProviderEditExperienceResponse {
  String? id;
  String? hospitalName;
  dynamic? description;
  String? designation;
  String? fromDate;
  String? toDate;
  bool? isPresent;
  String? userId;
  dynamic? createdBy;
  String? createdOn;
  dynamic? updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  ProviderEditExperienceResponse({this.id, this.hospitalName, this.description, this.designation, this.fromDate, this.toDate, this.isPresent, this.userId, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  ProviderEditExperienceResponse.fromJson(Map<dynamic, dynamic> json) {
    this.id = json["id"];
    this.hospitalName = json["hospitalName"];
    this.description = json["description"];
    this.designation = json["designation"];
    this.fromDate = json["fromDate"];
    this.toDate = json["toDate"];
    this.isPresent = json["isPresent"];
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
    data["hospitalName"] = this.hospitalName;
    data["description"] = this.description;
    data["designation"] = this.designation;
    data["fromDate"] = this.fromDate;
    data["toDate"] = this.toDate;
    data["isPresent"] = this.isPresent;
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