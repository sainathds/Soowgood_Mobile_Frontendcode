import 'dart:convert';

List<ProviderAwardListResponse> ProviderAwardListResponseFromJsonList(dynamic str) => List<ProviderAwardListResponse>.from(json.decode(str).map((x) => ProviderAwardListResponse.fromJson(x)));

String ProviderAwardListResponseToJsonList(List<ProviderAwardListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderAwardListResponse {
  String? _id;
  String? _name;
  Null? _description;
  Null? _url;
  int? _receivedYear;
  String? _userId;
  Null? _createdBy;
  String? _createdOn;
  Null? _updatedBy;
  String? _updatedOn;
  bool? _isDeleted;
  bool? _isActive;

  ProviderAwardListResponse(
      {String? id,
        String? name,
        Null? description,
        Null? url,
        int? receivedYear,
        String? userId,
        Null? createdBy,
        String? createdOn,
        Null? updatedBy,
        String? updatedOn,
        bool? isDeleted,
        bool? isActive}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (description != null) {
      this._description = description;
    }
    if (url != null) {
      this._url = url;
    }
    if (receivedYear != null) {
      this._receivedYear = receivedYear;
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
  Null? get description => _description;
  set description(Null? description) => _description = description;
  Null? get url => _url;
  set url(Null? url) => _url = url;
  int? get receivedYear => _receivedYear;
  set receivedYear(int? receivedYear) => _receivedYear = receivedYear;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  Null? get createdBy => _createdBy;
  set createdBy(Null? createdBy) => _createdBy = createdBy;
  String? get createdOn => _createdOn;
  set createdOn(String? createdOn) => _createdOn = createdOn;
  Null? get updatedBy => _updatedBy;
  set updatedBy(Null? updatedBy) => _updatedBy = updatedBy;
  String? get updatedOn => _updatedOn;
  set updatedOn(String? updatedOn) => _updatedOn = updatedOn;
  bool? get isDeleted => _isDeleted;
  set isDeleted(bool? isDeleted) => _isDeleted = isDeleted;
  bool? get isActive => _isActive;
  set isActive(bool? isActive) => _isActive = isActive;

  ProviderAwardListResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _url = json['url'];
    _receivedYear = json['receivedYear'];
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
    data['description'] = this._description;
    data['url'] = this._url;
    data['receivedYear'] = this._receivedYear;
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
