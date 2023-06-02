class VerifyUserRequest {
  String? _email;
  String? _userRole;

  VerifyUserRequest({String? email, String? userRole}) {
    if (email != null) {
      this._email = email;
    }
    if (userRole != null) {
      this._userRole = userRole;
    }
  }

  String? get email => _email;
  set email(String? email) => _email = email;
  String? get userRole => _userRole;
  set userRole(String? userRole) => _userRole = userRole;

  VerifyUserRequest.fromJson(Map<String, dynamic> json) {
    _email = json['Email'];
    _userRole = json['UserRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this._email;
    data['UserRole'] = this._userRole;
    return data;
  }
}
