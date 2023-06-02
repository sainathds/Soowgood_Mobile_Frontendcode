class ProviderBasicInfoRequest {
  String? _id;
  String? _fullname;
  String? _gender;
  String? _dateofbirth;
  String? _bloodgroup;
  String? _email;
  String? _phonenumber;
  String? _username;
  String? _currentaddress;
  String? _city;
  String? _state;
  String? _postalCode;
  String? _country;
  String? _aboutme;
  String? _usertype;

  ProviderBasicInfoRequest(
      {String? id,
        String? fullname,
        String? gender,
        String? dateofbirth,
        String? bloodgroup,
        String? email,
        String? phonenumber,
        String? username,
        String? currentaddress,
        String? city,
        String? state,
        String? postalCode,
        String? country,
        String? aboutme,
        String? usertype}) {
    if (id != null) {
      this._id = id;
    }
    if (fullname != null) {
      this._fullname = fullname;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (dateofbirth != null) {
      this._dateofbirth = dateofbirth;
    }
    if (bloodgroup != null) {
      this._bloodgroup = bloodgroup;
    }
    if (email != null) {
      this._email = email;
    }
    if (phonenumber != null) {
      this._phonenumber = phonenumber;
    }
    if (username != null) {
      this._username = username;
    }
    if (currentaddress != null) {
      this._currentaddress = currentaddress;
    }
    if (city != null) {
      this._city = city;
    }
    if (state != null) {
      this._state = state;
    }
    if (postalCode != null) {
      this._postalCode = postalCode;
    }
    if (country != null) {
      this._country = country;
    }
    if (aboutme != null) {
      this._aboutme = aboutme;
    }
    if (usertype != null) {
      this._usertype = usertype;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get fullname => _fullname;
  set fullname(String? fullname) => _fullname = fullname;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get dateofbirth => _dateofbirth;
  set dateofbirth(String? dateofbirth) => _dateofbirth = dateofbirth;
  String? get bloodgroup => _bloodgroup;
  set bloodgroup(String? bloodgroup) => _bloodgroup = bloodgroup;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phonenumber => _phonenumber;
  set phonenumber(String? phonenumber) => _phonenumber = phonenumber;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get currentaddress => _currentaddress;
  set currentaddress(String? currentaddress) =>
      _currentaddress = currentaddress;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get state => _state;
  set state(String? state) => _state = state;
  String? get postalCode => _postalCode;
  set postalCode(String? postalCode) => _postalCode = postalCode;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get aboutme => _aboutme;
  set aboutme(String? aboutme) => _aboutme = aboutme;
  String? get usertype => _usertype;
  set usertype(String? usertype) => _usertype = usertype;

  ProviderBasicInfoRequest.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _fullname = json['fullname'];
    _gender = json['gender'];
    _dateofbirth = json['dateofbirth'];
    _bloodgroup = json['bloodgroup'];
    _email = json['email'];
    _phonenumber = json['phonenumber'];
    _username = json['username'];
    _currentaddress = json['currentaddress'];
    _city = json['city'];
    _state = json['state'];
    _postalCode = json['postalCode'];
    _country = json['country'];
    _aboutme = json['aboutme'];
    _usertype = json['usertype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['fullname'] = this._fullname;
    data['gender'] = this._gender;
    data['dateofbirth'] = this._dateofbirth;
    data['bloodgroup'] = this._bloodgroup;
    data['email'] = this._email;
    data['phonenumber'] = this._phonenumber;
    data['username'] = this._username;
    data['currentaddress'] = this._currentaddress;
    data['city'] = this._city;
    data['state'] = this._state;
    data['postalCode'] = this._postalCode;
    data['country'] = this._country;
    data['aboutme'] = this._aboutme;
    data['usertype'] = this._usertype;
    return data;
  }
}
