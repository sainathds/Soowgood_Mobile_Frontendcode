class ProviderBasicInfoResponse {
  Null? _verificationotp;
  String? _success;
  String? _message;
  Null? _email;
  Null? _phonenumber;
  Null? _userRole;
  Null? _currentverificationotp;
  Null? _userName;
  Null? _id;
  Null? _concurrencyStamp;
  Null? _profilePicture;
  Null? _code;
  Null? _accessToken;
  Null? _elements;

  ProviderBasicInfoResponse(
      {Null? verificationotp,
        String? success,
        String? message,
        Null? email,
        Null? phonenumber,
        Null? userRole,
        Null? currentverificationotp,
        Null? userName,
        Null? id,
        Null? concurrencyStamp,
        Null? profilePicture,
        Null? code,
        Null? accessToken,
        Null? elements}) {
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

  Null? get verificationotp => _verificationotp;
  set verificationotp(Null? verificationotp) =>
      _verificationotp = verificationotp;
  String? get success => _success;
  set success(String? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;
  Null? get email => _email;
  set email(Null? email) => _email = email;
  Null? get phonenumber => _phonenumber;
  set phonenumber(Null? phonenumber) => _phonenumber = phonenumber;
  Null? get userRole => _userRole;
  set userRole(Null? userRole) => _userRole = userRole;
  Null? get currentverificationotp => _currentverificationotp;
  set currentverificationotp(Null? currentverificationotp) =>
      _currentverificationotp = currentverificationotp;
  Null? get userName => _userName;
  set userName(Null? userName) => _userName = userName;
  Null? get id => _id;
  set id(Null? id) => _id = id;
  Null? get concurrencyStamp => _concurrencyStamp;
  set concurrencyStamp(Null? concurrencyStamp) =>
      _concurrencyStamp = concurrencyStamp;
  Null? get profilePicture => _profilePicture;
  set profilePicture(Null? profilePicture) => _profilePicture = profilePicture;
  Null? get code => _code;
  set code(Null? code) => _code = code;
  Null? get accessToken => _accessToken;
  set accessToken(Null? accessToken) => _accessToken = accessToken;
  Null? get elements => _elements;
  set elements(Null? elements) => _elements = elements;

  ProviderBasicInfoResponse.fromJson(Map<dynamic, dynamic> json) {
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
