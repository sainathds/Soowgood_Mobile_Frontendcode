import 'dart:convert';

List<ProviderProfileScoreResponse> ProviderProfileScoreResponseFromJsonList(dynamic str) => List<ProviderProfileScoreResponse>.from(json.decode(str).map((x) => ProviderProfileScoreResponse.fromJson(x)));

String ProviderProfileScoreResponseToJsonList(List<ProviderProfileScoreResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ProviderProfileScoreResponse {
  String? _fullName;
  Null? _designation;
  String? _gender;
  String? _phoneNumber;
  String? _email;
  String? _address;
  String? _serviceName;
  String? _specialization;
  String? _typeId;
  String? _degreeName;
  String? _institution;
  String? _hospitalName;
  String? _hospitalDesignation;
  String? _clinicAddress;
  Null? _clinicName;
  String? _appointmentSetup;
  String? _profileScore;

  ProviderProfileScoreResponse(
      {String? fullName,
        Null? designation,
        String? gender,
        String? phoneNumber,
        String? email,
        String? address,
        String? serviceName,
        String? specialization,
        String? typeId,
        String? degreeName,
        String? institution,
        String? hospitalName,
        String? hospitalDesignation,
        String? clinicAddress,
        Null? clinicName,
        String? appointmentSetup,
        String? profileScore}) {
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (designation != null) {
      this._designation = designation;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (phoneNumber != null) {
      this._phoneNumber = phoneNumber;
    }
    if (email != null) {
      this._email = email;
    }
    if (address != null) {
      this._address = address;
    }
    if (serviceName != null) {
      this._serviceName = serviceName;
    }
    if (specialization != null) {
      this._specialization = specialization;
    }
    if (typeId != null) {
      this._typeId = typeId;
    }
    if (degreeName != null) {
      this._degreeName = degreeName;
    }
    if (institution != null) {
      this._institution = institution;
    }
    if (hospitalName != null) {
      this._hospitalName = hospitalName;
    }
    if (hospitalDesignation != null) {
      this._hospitalDesignation = hospitalDesignation;
    }
    if (clinicAddress != null) {
      this._clinicAddress = clinicAddress;
    }
    if (clinicName != null) {
      this._clinicName = clinicName;
    }
    if (appointmentSetup != null) {
      this._appointmentSetup = appointmentSetup;
    }
    if (profileScore != null) {
      this._profileScore = profileScore;
    }
  }

  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  Null? get designation => _designation;
  set designation(Null? designation) => _designation = designation;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get serviceName => _serviceName;
  set serviceName(String? serviceName) => _serviceName = serviceName;
  String? get specialization => _specialization;
  set specialization(String? specialization) =>
      _specialization = specialization;
  String? get typeId => _typeId;
  set typeId(String? typeId) => _typeId = typeId;
  String? get degreeName => _degreeName;
  set degreeName(String? degreeName) => _degreeName = degreeName;
  String? get institution => _institution;
  set institution(String? institution) => _institution = institution;
  String? get hospitalName => _hospitalName;
  set hospitalName(String? hospitalName) => _hospitalName = hospitalName;
  String? get hospitalDesignation => _hospitalDesignation;
  set hospitalDesignation(String? hospitalDesignation) =>
      _hospitalDesignation = hospitalDesignation;
  String? get clinicAddress => _clinicAddress;
  set clinicAddress(String? clinicAddress) => _clinicAddress = clinicAddress;
  Null? get clinicName => _clinicName;
  set clinicName(Null? clinicName) => _clinicName = clinicName;
  String? get appointmentSetup => _appointmentSetup;
  set appointmentSetup(String? appointmentSetup) =>
      _appointmentSetup = appointmentSetup;
  String? get profileScore => _profileScore;
  set profileScore(String? profileScore) => _profileScore = profileScore;

  ProviderProfileScoreResponse.fromJson(Map<String, dynamic> json) {
    _fullName = json['fullName'];
    _designation = json['designation'];
    _gender = json['gender'];
    _phoneNumber = json['phoneNumber'];
    _email = json['email'];
    _address = json['address'];
    _serviceName = json['serviceName'];
    _specialization = json['specialization'];
    _typeId = json['typeId'];
    _degreeName = json['degreeName'];
    _institution = json['institution'];
    _hospitalName = json['hospitalName'];
    _hospitalDesignation = json['hospitalDesignation'];
    _clinicAddress = json['clinicAddress'];
    _clinicName = json['clinicName'];
    _appointmentSetup = json['appointmentSetup'];
    _profileScore = json['profileScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this._fullName;
    data['designation'] = this._designation;
    data['gender'] = this._gender;
    data['phoneNumber'] = this._phoneNumber;
    data['email'] = this._email;
    data['address'] = this._address;
    data['serviceName'] = this._serviceName;
    data['specialization'] = this._specialization;
    data['typeId'] = this._typeId;
    data['degreeName'] = this._degreeName;
    data['institution'] = this._institution;
    data['hospitalName'] = this._hospitalName;
    data['hospitalDesignation'] = this._hospitalDesignation;
    data['clinicAddress'] = this._clinicAddress;
    data['clinicName'] = this._clinicName;
    data['appointmentSetup'] = this._appointmentSetup;
    data['profileScore'] = this._profileScore;
    return data;
  }
}
