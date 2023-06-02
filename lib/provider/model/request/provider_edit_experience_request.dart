class ProviderEditExperienceRequest {
  String? id;
  String? hospitalName;
  String? designation;
  String? userId;
  String? fromDate;
  String? toDate;
  bool? isPresent;

  ProviderEditExperienceRequest({this.id, this.hospitalName, this.designation, this.userId, this.fromDate, this.toDate, this.isPresent});

  ProviderEditExperienceRequest.fromJson(Map<String, dynamic> json) {
    this.id = json["Id"];
    this.hospitalName = json["HospitalName"];
    this.designation = json["Designation"];
    this.userId = json["UserId"];
    this.fromDate = json["FromDate"];
    this.toDate = json["ToDate"];
    this.isPresent = json["IsPresent"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Id"] = this.id;
    data["HospitalName"] = this.hospitalName;
    data["Designation"] = this.designation;
    data["UserId"] = this.userId;
    data["FromDate"] = this.fromDate;
    data["ToDate"] = this.toDate;
    data["IsPresent"] = this.isPresent;
    return data;
  }
}