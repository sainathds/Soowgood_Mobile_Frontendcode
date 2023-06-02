class ProviderEditEducationRequest {
  String? _id;
  String? _name;
  String? _institution;
  String? _userId;
  String? _yearOfCompletion;

  ProviderEditEducationRequest(
      {String? id,
        String? name,
        String? institution,
        String? userId,
        String? yearOfCompletion}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (institution != null) {
      this._institution = institution;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (yearOfCompletion != null) {
      this._yearOfCompletion = yearOfCompletion;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get institution => _institution;
  set institution(String? institution) => _institution = institution;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get yearOfCompletion => _yearOfCompletion;
  set yearOfCompletion(String? yearOfCompletion) =>
      _yearOfCompletion = yearOfCompletion;

  ProviderEditEducationRequest.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _name = json['Name'];
    _institution = json['Institution'];
    _userId = json['UserId'];
    _yearOfCompletion = json['YearOfCompletion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['Name'] = this._name;
    data['Institution'] = this._institution;
    data['UserId'] = this._userId;
    data['YearOfCompletion'] = this._yearOfCompletion;
    return data;
  }
}
