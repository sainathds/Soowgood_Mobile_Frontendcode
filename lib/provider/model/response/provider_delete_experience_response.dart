class ProviderDeleteExperienceResponse {
  String? _id;
  Null? _hospitalName;
  Null? _description;
  Null? _designation;
  String? _fromDate;
  String? _toDate;
  bool? _isPresent;
  String? _userId;
  Null? _createdBy;
  String? _createdOn;
  Null? _updatedBy;
  String? _updatedOn;
  bool? _isDeleted;
  bool? _isActive;

  ProviderDeleteExperienceResponse(
      {String? id,
        Null? hospitalName,
        Null? description,
        Null? designation,
        String? fromDate,
        String? toDate,
        bool? isPresent,
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
    if (hospitalName != null) {
      this._hospitalName = hospitalName;
    }
    if (description != null) {
      this._description = description;
    }
    if (designation != null) {
      this._designation = designation;
    }
    if (fromDate != null) {
      this._fromDate = fromDate;
    }
    if (toDate != null) {
      this._toDate = toDate;
    }
    if (isPresent != null) {
      this._isPresent = isPresent;
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
  Null? get hospitalName => _hospitalName;
  set hospitalName(Null? hospitalName) => _hospitalName = hospitalName;
  Null? get description => _description;
  set description(Null? description) => _description = description;
  Null? get designation => _designation;
  set designation(Null? designation) => _designation = designation;
  String? get fromDate => _fromDate;
  set fromDate(String? fromDate) => _fromDate = fromDate;
  String? get toDate => _toDate;
  set toDate(String? toDate) => _toDate = toDate;
  bool? get isPresent => _isPresent;
  set isPresent(bool? isPresent) => _isPresent = isPresent;
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

  ProviderDeleteExperienceResponse.fromJson(Map<dynamic, dynamic> json) {
    _id = json['id'];
    _hospitalName = json['hospitalName'];
    _description = json['description'];
    _designation = json['designation'];
    _fromDate = json['fromDate'];
    _toDate = json['toDate'];
    _isPresent = json['isPresent'];
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
    data['hospitalName'] = this._hospitalName;
    data['description'] = this._description;
    data['designation'] = this._designation;
    data['fromDate'] = this._fromDate;
    data['toDate'] = this._toDate;
    data['isPresent'] = this._isPresent;
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
