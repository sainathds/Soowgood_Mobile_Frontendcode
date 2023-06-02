class ProviderDeleteExperienceRequest {
  String? _id;
  String? _userId;

  ProviderDeleteExperienceRequest({String? id, String? userId}) {
    if (id != null) {
      this._id = id;
    }
    if (userId != null) {
      this._userId = userId;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;

  ProviderDeleteExperienceRequest.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['UserId'] = this._userId;
    return data;
  }
}
