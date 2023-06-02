class LoginResponse {
  int? _installationId;
  dynamic? _otherEmail;
  String? _registrationDate;
  dynamic? _othersMemberEmail;
  String? _profilePicture;
  dynamic? _firstName;
  dynamic? _lastName;
  String? _fullName;
  String? _dateOfBirth;
  dynamic? _designation;
  String? _memberSince;
  dynamic? _website;
  dynamic? _facebook;
  dynamic? _twitter;
  dynamic? _status;
  String? _bloodGroup;
  int? _gender;
  int? _maritalStatus;
  dynamic? _userActivities;
  String? _message;
  String? _userRole;
  bool? _isOrganizational;
  bool? _isAssignedFromOrganization;
  bool? _isConfirmedByAdmin;
  String? _id;
  String? _userName;
  String? _normalizedUserName;
  String? _email;
  String? _normalizedEmail;
  bool? _emailConfirmed;
  String? _passwordHash;
  String? _securityStamp;
  String? _concurrencyStamp;
  String? _phoneNumber;
  bool? _phoneNumberConfirmed;
  bool? _twoFactorEnabled;
  dynamic? _lockoutEnd;
  bool? _lockoutEnabled;
  int? _accessFailedCount;

  LoginResponse(
      {int? installationId,
        dynamic? otherEmail,
        String? registrationDate,
        dynamic? othersMemberEmail,
        String? profilePicture,
        dynamic? firstName,
        dynamic? lastName,
        String? fullName,
        String? dateOfBirth,
        dynamic? designation,
        String? memberSince,
        dynamic? website,
        dynamic? facebook,
        dynamic? twitter,
        dynamic? status,
        String? bloodGroup,
        int? gender,
        int? maritalStatus,
        dynamic? userActivities,
        String? message,
        String? userRole,
        bool? isOrganizational,
        bool? isAssignedFromOrganization,
        bool? isConfirmedByAdmin,
        String? id,
        String? userName,
        String? normalizedUserName,
        String? email,
        String? normalizedEmail,
        bool? emailConfirmed,
        String? passwordHash,
        String? securityStamp,
        String? concurrencyStamp,
        String? phoneNumber,
        bool? phoneNumberConfirmed,
        bool? twoFactorEnabled,
        dynamic? lockoutEnd,
        bool? lockoutEnabled,
        int? accessFailedCount}) {
    if (installationId != null) {
      this._installationId = installationId;
    }
    if (otherEmail != null) {
      this._otherEmail = otherEmail;
    }
    if (registrationDate != null) {
      this._registrationDate = registrationDate;
    }
    if (othersMemberEmail != null) {
      this._othersMemberEmail = othersMemberEmail;
    }
    if (profilePicture != null) {
      this._profilePicture = profilePicture;
    }
    if (firstName != null) {
      this._firstName = firstName;
    }
    if (lastName != null) {
      this._lastName = lastName;
    }
    if (fullName != null) {
      this._fullName = fullName;
    }
    if (dateOfBirth != null) {
      this._dateOfBirth = dateOfBirth;
    }
    if (designation != null) {
      this._designation = designation;
    }
    if (memberSince != null) {
      this._memberSince = memberSince;
    }
    if (website != null) {
      this._website = website;
    }
    if (facebook != null) {
      this._facebook = facebook;
    }
    if (twitter != null) {
      this._twitter = twitter;
    }
    if (status != null) {
      this._status = status;
    }
    if (bloodGroup != null) {
      this._bloodGroup = bloodGroup;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (maritalStatus != null) {
      this._maritalStatus = maritalStatus;
    }
    if (userActivities != null) {
      this._userActivities = userActivities;
    }
    if (message != null) {
      this._message = message;
    }
    if (userRole != null) {
      this._userRole = userRole;
    }
    if (isOrganizational != null) {
      this._isOrganizational = isOrganizational;
    }
    if (isAssignedFromOrganization != null) {
      this._isAssignedFromOrganization = isAssignedFromOrganization;
    }
    if (isConfirmedByAdmin != null) {
      this._isConfirmedByAdmin = isConfirmedByAdmin;
    }
    if (id != null) {
      this._id = id;
    }
    if (userName != null) {
      this._userName = userName;
    }
    if (normalizedUserName != null) {
      this._normalizedUserName = normalizedUserName;
    }
    if (email != null) {
      this._email = email;
    }
    if (normalizedEmail != null) {
      this._normalizedEmail = normalizedEmail;
    }
    if (emailConfirmed != null) {
      this._emailConfirmed = emailConfirmed;
    }
    if (passwordHash != null) {
      this._passwordHash = passwordHash;
    }
    if (securityStamp != null) {
      this._securityStamp = securityStamp;
    }
    if (concurrencyStamp != null) {
      this._concurrencyStamp = concurrencyStamp;
    }
    if (phoneNumber != null) {
      this._phoneNumber = phoneNumber;
    }
    if (phoneNumberConfirmed != null) {
      this._phoneNumberConfirmed = phoneNumberConfirmed;
    }
    if (twoFactorEnabled != null) {
      this._twoFactorEnabled = twoFactorEnabled;
    }
    if (lockoutEnd != null) {
      this._lockoutEnd = lockoutEnd;
    }
    if (lockoutEnabled != null) {
      this._lockoutEnabled = lockoutEnabled;
    }
    if (accessFailedCount != null) {
      this._accessFailedCount = accessFailedCount;
    }
  }

  int? get installationId => _installationId;
  set installationId(int? installationId) => _installationId = installationId;
  dynamic? get otherEmail => _otherEmail;
  set otherEmail(dynamic? otherEmail) => _otherEmail = otherEmail;
  String? get registrationDate => _registrationDate;
  set registrationDate(String? registrationDate) =>
      _registrationDate = registrationDate;
  dynamic? get othersMemberEmail => _othersMemberEmail;
  set othersMemberEmail(dynamic? othersMemberEmail) =>
      _othersMemberEmail = othersMemberEmail;
  String? get profilePicture => _profilePicture;
  set profilePicture(String? profilePicture) =>
      _profilePicture = profilePicture;
  dynamic? get firstName => _firstName;
  set firstName(dynamic? firstName) => _firstName = firstName;
  dynamic? get lastName => _lastName;
  set lastName(dynamic? lastName) => _lastName = lastName;
  String? get fullName => _fullName;
  set fullName(String? fullName) => _fullName = fullName;
  String? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(String? dateOfBirth) => _dateOfBirth = dateOfBirth;
  dynamic? get designation => _designation;
  set designation(dynamic? designation) => _designation = designation;
  String? get memberSince => _memberSince;
  set memberSince(String? memberSince) => _memberSince = memberSince;
  dynamic? get website => _website;
  set website(dynamic? website) => _website = website;
  dynamic? get facebook => _facebook;
  set facebook(dynamic? facebook) => _facebook = facebook;
  dynamic? get twitter => _twitter;
  set twitter(dynamic? twitter) => _twitter = twitter;
  dynamic? get status => _status;
  set status(dynamic? status) => _status = status;
  String? get bloodGroup => _bloodGroup;
  set bloodGroup(String? bloodGroup) => _bloodGroup = bloodGroup;
  int? get gender => _gender;
  set gender(int? gender) => _gender = gender;
  int? get maritalStatus => _maritalStatus;
  set maritalStatus(int? maritalStatus) => _maritalStatus = maritalStatus;
  dynamic? get userActivities => _userActivities;
  set userActivities(dynamic? userActivities) => _userActivities = userActivities;
  String? get message => _message;
  set message(String? message) => _message = message;
  String? get userRole => _userRole;
  set userRole(String? userRole) => _userRole = userRole;
  bool? get isOrganizational => _isOrganizational;
  set isOrganizational(bool? isOrganizational) =>
      _isOrganizational = isOrganizational;
  bool? get isAssignedFromOrganization => _isAssignedFromOrganization;
  set isAssignedFromOrganization(bool? isAssignedFromOrganization) =>
      _isAssignedFromOrganization = isAssignedFromOrganization;
  bool? get isConfirmedByAdmin => _isConfirmedByAdmin;
  set isConfirmedByAdmin(bool? isConfirmedByAdmin) =>
      _isConfirmedByAdmin = isConfirmedByAdmin;
  String? get id => _id;
  set id(String? id) => _id = id;
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;
  String? get normalizedUserName => _normalizedUserName;
  set normalizedUserName(String? normalizedUserName) =>
      _normalizedUserName = normalizedUserName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get normalizedEmail => _normalizedEmail;
  set normalizedEmail(String? normalizedEmail) =>
      _normalizedEmail = normalizedEmail;
  bool? get emailConfirmed => _emailConfirmed;
  set emailConfirmed(bool? emailConfirmed) => _emailConfirmed = emailConfirmed;
  String? get passwordHash => _passwordHash;
  set passwordHash(String? passwordHash) => _passwordHash = passwordHash;
  String? get securityStamp => _securityStamp;
  set securityStamp(String? securityStamp) => _securityStamp = securityStamp;
  String? get concurrencyStamp => _concurrencyStamp;
  set concurrencyStamp(String? concurrencyStamp) =>
      _concurrencyStamp = concurrencyStamp;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  bool? get phoneNumberConfirmed => _phoneNumberConfirmed;
  set phoneNumberConfirmed(bool? phoneNumberConfirmed) =>
      _phoneNumberConfirmed = phoneNumberConfirmed;
  bool? get twoFactorEnabled => _twoFactorEnabled;
  set twoFactorEnabled(bool? twoFactorEnabled) =>
      _twoFactorEnabled = twoFactorEnabled;
  dynamic? get lockoutEnd => _lockoutEnd;
  set lockoutEnd(dynamic? lockoutEnd) => _lockoutEnd = lockoutEnd;
  bool? get lockoutEnabled => _lockoutEnabled;
  set lockoutEnabled(bool? lockoutEnabled) => _lockoutEnabled = lockoutEnabled;
  int? get accessFailedCount => _accessFailedCount;
  set accessFailedCount(int? accessFailedCount) =>
      _accessFailedCount = accessFailedCount;

  LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    _installationId = json['installationId'];
    _otherEmail = json['otherEmail'];
    _registrationDate = json['registrationDate'];
    _othersMemberEmail = json['othersMemberEmail'];
    _profilePicture = json['profilePicture'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _fullName = json['fullName'];
    _dateOfBirth = json['dateOfBirth'];
    _designation = json['designation'];
    _memberSince = json['memberSince'];
    _website = json['website'];
    _facebook = json['facebook'];
    _twitter = json['twitter'];
    _status = json['status'];
    _bloodGroup = json['bloodGroup'];
    _gender = json['gender'];
    _maritalStatus = json['maritalStatus'];
    _userActivities = json['userActivities'];
    _message = json['message'];
    _userRole = json['userRole'];
    _isOrganizational = json['isOrganizational'];
    _isAssignedFromOrganization = json['isAssignedFromOrganization'];
    _isConfirmedByAdmin = json['isConfirmedByAdmin'];
    _id = json['id'];
    _userName = json['userName'];
    _normalizedUserName = json['normalizedUserName'];
    _email = json['email'];
    _normalizedEmail = json['normalizedEmail'];
    _emailConfirmed = json['emailConfirmed'];
    _passwordHash = json['passwordHash'];
    _securityStamp = json['securityStamp'];
    _concurrencyStamp = json['concurrencyStamp'];
    _phoneNumber = json['phoneNumber'];
    _phoneNumberConfirmed = json['phoneNumberConfirmed'];
    _twoFactorEnabled = json['twoFactorEnabled'];
    _lockoutEnd = json['lockoutEnd'];
    _lockoutEnabled = json['lockoutEnabled'];
    _accessFailedCount = json['accessFailedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installationId'] = this._installationId;
    data['otherEmail'] = this._otherEmail;
    data['registrationDate'] = this._registrationDate;
    data['othersMemberEmail'] = this._othersMemberEmail;
    data['profilePicture'] = this._profilePicture;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['fullName'] = this._fullName;
    data['dateOfBirth'] = this._dateOfBirth;
    data['designation'] = this._designation;
    data['memberSince'] = this._memberSince;
    data['website'] = this._website;
    data['facebook'] = this._facebook;
    data['twitter'] = this._twitter;
    data['status'] = this._status;
    data['bloodGroup'] = this._bloodGroup;
    data['gender'] = this._gender;
    data['maritalStatus'] = this._maritalStatus;
    data['userActivities'] = this._userActivities;
    data['message'] = this._message;
    data['userRole'] = this._userRole;
    data['isOrganizational'] = this._isOrganizational;
    data['isAssignedFromOrganization'] = this._isAssignedFromOrganization;
    data['isConfirmedByAdmin'] = this._isConfirmedByAdmin;
    data['id'] = this._id;
    data['userName'] = this._userName;
    data['normalizedUserName'] = this._normalizedUserName;
    data['email'] = this._email;
    data['normalizedEmail'] = this._normalizedEmail;
    data['emailConfirmed'] = this._emailConfirmed;
    data['passwordHash'] = this._passwordHash;
    data['securityStamp'] = this._securityStamp;
    data['concurrencyStamp'] = this._concurrencyStamp;
    data['phoneNumber'] = this._phoneNumber;
    data['phoneNumberConfirmed'] = this._phoneNumberConfirmed;
    data['twoFactorEnabled'] = this._twoFactorEnabled;
    data['lockoutEnd'] = this._lockoutEnd;
    data['lockoutEnabled'] = this._lockoutEnabled;
    data['accessFailedCount'] = this._accessFailedCount;
    return data;
  }
}
