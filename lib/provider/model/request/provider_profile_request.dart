class ProviderProfileRequest {
  String? _id;

  ProviderProfileRequest({String? id}) {
    if (id != null) {
      this._id = id;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;

  ProviderProfileRequest.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    return data;
  }
}
