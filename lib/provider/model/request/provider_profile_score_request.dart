class ProviderProfileScoreRequest {
  String? _id;

  ProviderProfileScoreRequest({String? id}) {
    if (id != null) {
      this._id = id;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;

  ProviderProfileScoreRequest.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    return data;
  }
}
