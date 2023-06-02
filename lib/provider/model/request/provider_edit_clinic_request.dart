class ProviderEditClinicRequest {
  String? id;
  String? name;
  String? currentAddress;
  String? city;
  String? postalCode;
  String? state;
  String? country;
  String? userId;
  String? file1;
  String? file2;
  String? file3;
  String? isImageURLOptionalOne;
  String? isImageURLOptionalTwo;
  String? isImageURLOptionalThree;


  ProviderEditClinicRequest({this.id, this.name, this.currentAddress, this.city, this.postalCode, this.state, this.country, this.userId, this.file1, this.file2, this.file3, this.isImageURLOptionalOne, this.isImageURLOptionalTwo, this.isImageURLOptionalThree});

  ProviderEditClinicRequest.fromJson(Map<String, dynamic> json) {
    this.name = json["Name"];
    this.currentAddress = json["CurrentAddress"];
    this.city = json["City"];
    this.postalCode = json["PostalCode"];
    this.state = json["State"];
    this.country = json["Country"];
    this.userId = json["UserId"];
    this.file1 = json["File1"];
    this.file2 = json["File2"];
    this.file3 = json["File3"];
    this.isImageURLOptionalOne = json["IsImageURLOptionalOne"];
    this.isImageURLOptionalTwo = json["IsImageURLOptionalTwo"];
    this.isImageURLOptionalThree = json["IsImageURLOptionalThree"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Name"] = this.name;
    data["CurrentAddress"] = this.currentAddress;
    data["City"] = this.city;
    data["PostalCode"] = this.postalCode;
    data["State"] = this.state;
    data["Country"] = this.country;
    data["UserId"] = this.userId;
    data["File1"] = this.file1;
    data["File2"] = this.file2;
    data["File3"] = this.file3;
    data["IsImageURLOptionalOne"] = this.isImageURLOptionalOne;
    data["IsImageURLOptionalTwo"] = this.isImageURLOptionalTwo;
    data["IsImageURLOptionalThree"] = this.isImageURLOptionalThree;

    return data;
  }
}