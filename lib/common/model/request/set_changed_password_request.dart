class SetChangedPasswordRequest {
  String? _id;
  String? _oldPassword;
  String? _password;
  String? _confirmPassword;

  SetChangedPasswordRequest(
      {String? id,
        String? oldPassword,
        String? password,
        String? confirmPassword}) {
    if (id != null) {
      this._id = id;
    }
    if (oldPassword != null) {
      this._oldPassword = oldPassword;
    }
    if (password != null) {
      this._password = password;
    }
    if (confirmPassword != null) {
      this._confirmPassword = confirmPassword;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get oldPassword => _oldPassword;
  set oldPassword(String? oldPassword) => _oldPassword = oldPassword;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get confirmPassword => _confirmPassword;
  set confirmPassword(String? confirmPassword) =>
      _confirmPassword = confirmPassword;

  SetChangedPasswordRequest.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _oldPassword = json['OldPassword'];
    _password = json['Password'];
    _confirmPassword = json['ConfirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['OldPassword'] = this._oldPassword;
    data['Password'] = this._password;
    data['ConfirmPassword'] = this._confirmPassword;
    return data;
  }
}
