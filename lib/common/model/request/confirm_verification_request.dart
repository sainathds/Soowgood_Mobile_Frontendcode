class ConfirmVerificationRequest {
  String? _id;
  String? _userName;
  String? _verificationotp;
  String? _userRole;
  String? _currentverificationotp;

  ConfirmVerificationRequest(
      {String? id,
        String? userName,
        String? verificationotp,
        String? userRole,
        String? currentverificationotp}) {
    if (id != null) {
      this._id = id;
    }
    if (userName != null) {
      this._userName = userName;
    }
    if (verificationotp != null) {
      this._verificationotp = verificationotp;
    }
    if (userRole != null) {
      this._userRole = userRole;
    }
    if (currentverificationotp != null) {
      this._currentverificationotp = currentverificationotp;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;
  String? get verificationotp => _verificationotp;
  set verificationotp(String? verificationotp) =>
      _verificationotp = verificationotp;
  String? get userRole => _userRole;
  set userRole(String? userRole) => _userRole = userRole;
  String? get currentverificationotp => _currentverificationotp;
  set currentverificationotp(String? currentverificationotp) =>
      _currentverificationotp = currentverificationotp;

  ConfirmVerificationRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userName = json['userName'];
    _verificationotp = json['verificationotp'];
    _userRole = json['userRole'];
    _currentverificationotp = json['currentverificationotp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['userName'] = this._userName;
    data['verificationotp'] = this._verificationotp;
    data['userRole'] = this._userRole;
    data['currentverificationotp'] = this._currentverificationotp;
    return data;
  }
}
