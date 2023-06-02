class ProviderAddAwardRequest {
  String? _userId;
  String? _name;
  String? _receivedYear;

  ProviderAddAwardRequest(
      {String? userId, String? name, String? receivedYear}) {
    if (userId != null) {
      this._userId = userId;
    }
    if (name != null) {
      this._name = name;
    }
    if (receivedYear != null) {
      this._receivedYear = receivedYear;
    }
  }

  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get receivedYear => _receivedYear;
  set receivedYear(String? receivedYear) => _receivedYear = receivedYear;

  ProviderAddAwardRequest.fromJson(Map<String, dynamic> json) {
    _userId = json['UserId'];
    _name = json['Name'];
    _receivedYear = json['ReceivedYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this._userId;
    data['Name'] = this._name;
    data['ReceivedYear'] = this._receivedYear;
    return data;
  }
}
