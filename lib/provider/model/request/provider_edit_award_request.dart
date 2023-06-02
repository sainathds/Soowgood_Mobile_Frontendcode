class ProviderEditAwardRequest {
  String? id;
  String? userId;
  String? name;
  String? receivedYear;

  ProviderEditAwardRequest({this.id, this.userId, this.name, this.receivedYear});

  ProviderEditAwardRequest.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.userId = json["UserId"];
    this.name = json["Name"];
    this.receivedYear = json["ReceivedYear"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["UserId"] = this.userId;
    data["Name"] = this.name;
    data["ReceivedYear"] = this.receivedYear;
    return data;
  }
}