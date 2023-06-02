class ProviderEditClinicResponse {
  String? id;
  String? name;
  dynamic? optionalAddress;
  String? currentAddress;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? imageUrl;
  dynamic? imageUrlOptionalOne;
  String? imageUrlOptionalTwo;
  String? imageUrlOptionalThree;
  String? userId;
  dynamic? createdBy;
  String? createdOn;
  dynamic? updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  ProviderEditClinicResponse({this.id, this.name, this.optionalAddress, this.currentAddress, this.city, this.state, this.country, this.postalCode, this.imageUrl, this.imageUrlOptionalOne, this.imageUrlOptionalTwo, this.imageUrlOptionalThree, this.userId, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  ProviderEditClinicResponse.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.optionalAddress = json["optionalAddress"];
    this.currentAddress = json["currentAddress"];
    this.city = json["city"];
    this.state = json["state"];
    this.country = json["country"];
    this.postalCode = json["postalCode"];
    this.imageUrl = json["imageURL"];
    this.imageUrlOptionalOne = json["imageURLOptionalOne"];
    this.imageUrlOptionalTwo = json["imageURLOptionalTwo"];
    this.imageUrlOptionalThree = json["imageURLOptionalThree"];
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
    data["optionalAddress"] = this.optionalAddress;
    data["currentAddress"] = this.currentAddress;
    data["city"] = this.city;
    data["state"] = this.state;
    data["country"] = this.country;
    data["postalCode"] = this.postalCode;
    data["imageURL"] = this.imageUrl;
    data["imageURLOptionalOne"] = this.imageUrlOptionalOne;
    data["imageURLOptionalTwo"] = this.imageUrlOptionalTwo;
    data["imageURLOptionalThree"] = this.imageUrlOptionalThree;
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