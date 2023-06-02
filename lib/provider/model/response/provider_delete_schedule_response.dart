
class ProviderDeleteScheduleResponse {
  dynamic verificationotp;
  String? success;
  String? message;
  dynamic email;
  dynamic phonenumber;
  dynamic userRole;
  dynamic currentverificationotp;
  dynamic userName;
  dynamic id;
  dynamic concurrencyStamp;
  dynamic profilePicture;
  dynamic code;
  dynamic accessToken;
  dynamic elements;

  ProviderDeleteScheduleResponse({this.verificationotp, this.success, this.message, this.email, this.phonenumber, this.userRole, this.currentverificationotp, this.userName, this.id, this.concurrencyStamp, this.profilePicture, this.code, this.accessToken, this.elements});

  ProviderDeleteScheduleResponse.fromJson(Map<dynamic, dynamic> json) {
    verificationotp = json["verificationotp"];
    success = json["success"];
    message = json["message"];
    email = json["email"];
    phonenumber = json["phonenumber"];
    userRole = json["userRole"];
    currentverificationotp = json["currentverificationotp"];
    userName = json["userName"];
    id = json["id"];
    concurrencyStamp = json["concurrencyStamp"];
    profilePicture = json["profilePicture"];
    code = json["code"];
    accessToken = json["access_token"];
    elements = json["elements"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["verificationotp"] = verificationotp;
    _data["success"] = success;
    _data["message"] = message;
    _data["email"] = email;
    _data["phonenumber"] = phonenumber;
    _data["userRole"] = userRole;
    _data["currentverificationotp"] = currentverificationotp;
    _data["userName"] = userName;
    _data["id"] = id;
    _data["concurrencyStamp"] = concurrencyStamp;
    _data["profilePicture"] = profilePicture;
    _data["code"] = code;
    _data["access_token"] = accessToken;
    _data["elements"] = elements;
    return _data;
  }
}