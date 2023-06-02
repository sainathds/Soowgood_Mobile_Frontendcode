class ForgotPasswordResponse {
  String? _verificationotp;
  String? _success;
  String? _message;
  String? _email;
  dynamic? _phonenumber;
  String? _userRole;
  dynamic? _currentverificationotp;
  dynamic? _userName;
  String? _id;
  dynamic? _concurrencyStamp;
  dynamic? _profilePicture;
  dynamic? _code;
  dynamic? _accessToken;
  dynamic? _elements;

  ForgotPasswordResponse(
      {String? verificationotp,
        String? success,
        String? message,
        String? email,
        dynamic? phonenumber,
        String? userRole,
        dynamic? currentverificationotp,
        dynamic? userName,
        String? id,
        dynamic? concurrencyStamp,
        dynamic? profilePicture,
        dynamic? code,
        dynamic? accessToken,
        dynamic? elements}) {
    if (verificationotp != null) {
      this._verificationotp = verificationotp;
    }
    if (success != null) {
      this._success = success;
    }
    if (message != null) {
      this._message = message;
    }
    if (email != null) {
      this._email = email;
    }
    if (phonenumber != null) {
      this._phonenumber = phonenumber;
    }
    if (userRole != null) {
      this._userRole = userRole;
    }
    if (currentverificationotp != null) {
      this._currentverificationotp = currentverificationotp;
    }
    if (userName != null) {
      this._userName = userName;
    }
    if (id != null) {
      this._id = id;
    }
    if (concurrencyStamp != null) {
      this._concurrencyStamp = concurrencyStamp;
    }
    if (profilePicture != null) {
      this._profilePicture = profilePicture;
    }
    if (code != null) {
      this._code = code;
    }
    if (accessToken != null) {
      this._accessToken = accessToken;
    }
    if (elements != null) {
      this._elements = elements;
    }
  }

  String? get verificationotp => _verificationotp;
  set verificationotp(String? verificationotp) =>
      _verificationotp = verificationotp;
  String? get success => _success;
  set success(String? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;
  String? get email => _email;
  set email(String? email) => _email = email;
  dynamic? get phonenumber => _phonenumber;
  set phonenumber(dynamic? phonenumber) => _phonenumber = phonenumber;
  String? get userRole => _userRole;
  set userRole(String? userRole) => _userRole = userRole;
  dynamic? get currentverificationotp => _currentverificationotp;
  set currentverificationotp(dynamic? currentverificationotp) =>
      _currentverificationotp = currentverificationotp;
  dynamic? get userName => _userName;
  set userName(dynamic? userName) => _userName = userName;
  String? get id => _id;
  set id(String? id) => _id = id;
  dynamic? get concurrencyStamp => _concurrencyStamp;
  set concurrencyStamp(dynamic? concurrencyStamp) =>
      _concurrencyStamp = concurrencyStamp;
  dynamic? get profilePicture => _profilePicture;
  set profilePicture(dynamic? profilePicture) => _profilePicture = profilePicture;
  dynamic? get code => _code;
  set code(dynamic? code) => _code = code;
  dynamic? get accessToken => _accessToken;
  set accessToken(dynamic? accessToken) => _accessToken = accessToken;
  dynamic? get elements => _elements;
  set elements(dynamic? elements) => _elements = elements;

  ForgotPasswordResponse.fromJson(Map<dynamic, dynamic> json) {
    _verificationotp = json['verificationotp'];
    _success = json['success'];
    _message = json['message'];
    _email = json['email'];
    _phonenumber = json['phonenumber'];
    _userRole = json['userRole'];
    _currentverificationotp = json['currentverificationotp'];
    _userName = json['userName'];
    _id = json['id'];
    _concurrencyStamp = json['concurrencyStamp'];
    _profilePicture = json['profilePicture'];
    _code = json['code'];
    _accessToken = json['access_token'];
    _elements = json['elements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verificationotp'] = this._verificationotp;
    data['success'] = this._success;
    data['message'] = this._message;
    data['email'] = this._email;
    data['phonenumber'] = this._phonenumber;
    data['userRole'] = this._userRole;
    data['currentverificationotp'] = this._currentverificationotp;
    data['userName'] = this._userName;
    data['id'] = this._id;
    data['concurrencyStamp'] = this._concurrencyStamp;
    data['profilePicture'] = this._profilePicture;
    data['code'] = this._code;
    data['access_token'] = this._accessToken;
    data['elements'] = this._elements;
    return data;
  }
}
