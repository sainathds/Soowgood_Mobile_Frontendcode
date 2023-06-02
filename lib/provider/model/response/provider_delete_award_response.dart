
class ProviderDeleteAwardResponse {
  String? id;
  dynamic? name;
  dynamic? description;
  dynamic? url;
  int? receivedYear;
  String? userId;
  dynamic? createdBy;
  String? createdOn;
  dynamic? updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  ProviderDeleteAwardResponse({this.id, this.name, this.description, this.url, this.receivedYear, this.userId, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  ProviderDeleteAwardResponse.fromJson(Map<dynamic, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.description = json["description"];
    this.url = json["url"];
    this.receivedYear = json["receivedYear"];
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
    data["name"] = this.name;
    data["description"] = this.description;
    data["url"] = this.url;
    data["receivedYear"] = this.receivedYear;
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