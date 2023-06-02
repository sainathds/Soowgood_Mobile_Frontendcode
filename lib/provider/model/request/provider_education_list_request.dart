class ProviderEducationListRequest {
  String? _userId;

  ProviderEducationListRequest({String? userId}) {
    if (userId != null) {
      this._userId = userId;
    }
  }

  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;

  ProviderEducationListRequest.fromJson(Map<String, dynamic> json) {
    _userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this._userId;
    return data;
  }
}
