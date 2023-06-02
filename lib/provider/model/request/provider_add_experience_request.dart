class ProviderAddExperienceRequest {
  String? _hospitalName;
  String? _designation;
  String? _userId;
  String? _fromDate;
  String? _toDate;
  bool? _isPresent;

  ProviderAddExperienceRequest(
      {String? hospitalName,
        String? designation,
        String? userId,
        String? fromDate,
        String? toDate,
        bool? isPresent}) {
    if (hospitalName != null) {
      this._hospitalName = hospitalName;
    }
    if (designation != null) {
      this._designation = designation;
    }
    if (userId != null) {
      this._userId = userId;
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
  }

  String? get hospitalName => _hospitalName;
  set hospitalName(String? hospitalName) => _hospitalName = hospitalName;
  String? get designation => _designation;
  set designation(String? designation) => _designation = designation;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get fromDate => _fromDate;
  set fromDate(String? fromDate) => _fromDate = fromDate;
  String? get toDate => _toDate;
  set toDate(String? toDate) => _toDate = toDate;
  bool? get isPresent => _isPresent;
  set isPresent(bool? isPresent) => _isPresent = isPresent;

  ProviderAddExperienceRequest.fromJson(Map<String, dynamic> json) {
    _hospitalName = json['HospitalName'];
    _designation = json['Designation'];
    _userId = json['UserId'];
    _fromDate = json['FromDate'];
    _toDate = json['ToDate'];
    _isPresent = json['IsPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalName'] = this._hospitalName;
    data['Designation'] = this._designation;
    data['UserId'] = this._userId;
    data['FromDate'] = this._fromDate;
    data['ToDate'] = this._toDate;
    data['IsPresent'] = this._isPresent;
    return data;
  }
}
