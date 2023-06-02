class ForgotPasswordRequest {
  String? _email;

  ForgotPasswordRequest({String? email}) {
    if (email != null) {
      this._email = email;
    }
  }

  String? get email => _email;
  set email(String? email) => _email = email;

  ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    _email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this._email;
    return data;
  }
}
