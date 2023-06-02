import 'dart:convert';

List<ProviderEducationListResponse> ProviderEducationListResponseFromJsonList(dynamic str) => List<ProviderEducationListResponse>.from(json.decode(str).map((x) => ProviderEducationListResponse.fromJson(x)));

String ProviderEducationListResponseToJsonList(List<ProviderEducationListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ProviderEducationListResponse {
  String? _id;
  String? _name;
  String? _institution;
  int? _yearOfCompletion;
  String? _userId;
  String? _createdBy;
  String? _createdOn;
  String? _updatedBy;
  String? _updatedOn;
  bool? _isDeleted;
  bool? _isActive;

  ProviderEducationListResponse(
      {String? id,
        String? name,
        String? institution,
        int? yearOfCompletion,
        String? userId,
        String? createdBy,
        String? createdOn,
        String? updatedBy,
        String? updatedOn,
        bool? isDeleted,
        bool? isActive}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (institution != null) {
      this._institution = institution;
    }
    if (yearOfCompletion != null) {
      this._yearOfCompletion = yearOfCompletion;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (createdBy != null) {
      this._createdBy = createdBy;
    }
    if (createdOn != null) {
      this._createdOn = createdOn;
    }
    if (updatedBy != null) {
      this._updatedBy = updatedBy;
    }
    if (updatedOn != null) {
      this._updatedOn = updatedOn;
    }
    if (isDeleted != null) {
      this._isDeleted = isDeleted;
    }
    if (isActive != null) {
      this._isActive = isActive;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get institution => _institution;
  set institution(String? institution) => _institution = institution;
  int? get yearOfCompletion => _yearOfCompletion;
  set yearOfCompletion(int? yearOfCompletion) =>
      _yearOfCompletion = yearOfCompletion;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get createdBy => _createdBy;
  set createdBy(String? createdBy) => _createdBy = createdBy;
  String? get createdOn => _createdOn;
  set createdOn(String? createdOn) => _createdOn = createdOn;
  String? get updatedBy => _updatedBy;
  set updatedBy(String? updatedBy) => _updatedBy = updatedBy;
  String? get updatedOn => _updatedOn;
  set updatedOn(String? updatedOn) => _updatedOn = updatedOn;
  bool? get isDeleted => _isDeleted;
  set isDeleted(bool? isDeleted) => _isDeleted = isDeleted;
  bool? get isActive => _isActive;
  set isActive(bool? isActive) => _isActive = isActive;

  ProviderEducationListResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _institution = json['institution'];
    _yearOfCompletion = json['yearOfCompletion'];
    _userId = json['userId'];
    _createdBy = json['createdBy'];
    _createdOn = json['createdOn'];
    _updatedBy = json['updatedBy'];
    _updatedOn = json['updatedOn'];
    _isDeleted = json['isDeleted'];
    _isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['institution'] = this._institution;
    data['yearOfCompletion'] = this._yearOfCompletion;
    data['userId'] = this._userId;
    data['createdBy'] = this._createdBy;
    data['createdOn'] = this._createdOn;
    data['updatedBy'] = this._updatedBy;
    data['updatedOn'] = this._updatedOn;
    data['isDeleted'] = this._isDeleted;
    data['isActive'] = this._isActive;
    return data;
  }
}
