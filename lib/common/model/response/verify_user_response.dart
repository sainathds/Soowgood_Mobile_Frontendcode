import 'dart:convert';

List<VerifyUserResponse> VerifyUserResponseFromJson(dynamic str) => List<VerifyUserResponse>.from(json.decode(str).map((x) => VerifyUserResponse.fromJson(x)));

class VerifyUserResponse {
  dynamic verificationotp;
  String? success;
  String? message;
  dynamic email;
  dynamic phonenumber;
  String? userRole;
  dynamic currentverificationotp;
  dynamic userName;
  dynamic id;
  dynamic concurrencyStamp;
  dynamic profilePicture;
  dynamic code;
  dynamic accessToken;
  dynamic elements;

  VerifyUserResponse({this.verificationotp, this.success, this.message, this.email, this.phonenumber, this.userRole, this.currentverificationotp, this.userName, this.id, this.concurrencyStamp, this.profilePicture, this.code, this.accessToken, this.elements});

  VerifyUserResponse.fromJson(Map<dynamic, dynamic> json) {
    this.verificationotp = json["verificationotp"];
    this.success = json["success"];
    this.message = json["message"];
    this.email = json["email"];
    this.phonenumber = json["phonenumber"];
    this.userRole = json["userRole"];
    this.currentverificationotp = json["currentverificationotp"];
    this.userName = json["userName"];
    this.id = json["id"];
    this.concurrencyStamp = json["concurrencyStamp"];
    this.profilePicture = json["profilePicture"];
    this.code = json["code"];
    this.accessToken = json["access_token"];
    this.elements = json["elements"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["verificationotp"] = this.verificationotp;
    data["success"] = this.success;
    data["message"] = this.message;
    data["email"] = this.email;
    data["phonenumber"] = this.phonenumber;
    data["userRole"] = this.userRole;
    data["currentverificationotp"] = this.currentverificationotp;
    data["userName"] = this.userName;
    data["id"] = this.id;
    data["concurrencyStamp"] = this.concurrencyStamp;
    data["profilePicture"] = this.profilePicture;
    data["code"] = this.code;
    data["access_token"] = this.accessToken;
    data["elements"] = this.elements;
    return data;
  }
}