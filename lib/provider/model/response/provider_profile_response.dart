
import 'dart:convert';

List<ProviderProfileResponse> ProviderProfileResponseFromJsonList(dynamic str) => List<ProviderProfileResponse>.from(json.decode(str).map((x) => ProviderProfileResponse.fromJson(x)));

String ProfileDetailsResponseToJsonList(List<ProviderProfileResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderProfileResponse {
  String? _id;
  String? _fullname;
  String? _username;
  String? _dob;
  String? _gender;
  String? _bloodgroup;
  String? _email;
  String? _mobileno;
  String? _maritalstatus;
  String? _currentaddress;
  String? _city;
  String? _statename;
  String? _postalcode;
  String? _country;
  String? _addressid;
  String? _aboutme;
  String? _profilephoto;
  String? _foldername;

  ProviderProfileResponse(
      {String? id,
        String? fullname,
        String? username,
        String? dob,
        String? gender,
        String? bloodgroup,
        String? email,
        String? mobileno,
        String? maritalstatus,
        String? currentaddress,
        String? city,
        String? statename,
        String? postalcode,
        String? country,
        String? addressid,
        String? aboutme,
        String? profilephoto,
        String? foldername}) {
    if (id != null) {
      this._id = id;
    }
    if (fullname != null) {
      this._fullname = fullname;
    }
    if (username != null) {
      this._username = username;
    }
    if (dob != null) {
      this._dob = dob;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (bloodgroup != null) {
      this._bloodgroup = bloodgroup;
    }
    if (email != null) {
      this._email = email;
    }
    if (mobileno != null) {
      this._mobileno = mobileno;
    }
    if (maritalstatus != null) {
      this._maritalstatus = maritalstatus;
    }
    if (currentaddress != null) {
      this._currentaddress = currentaddress;
    }
    if (city != null) {
      this._city = city;
    }
    if (statename != null) {
      this._statename = statename;
    }
    if (postalcode != null) {
      this._postalcode = postalcode;
    }
    if (country != null) {
      this._country = country;
    }
    if (addressid != null) {
      this._addressid = addressid;
    }
    if (aboutme != null) {
      this._aboutme = aboutme;
    }
    if (profilephoto != null) {
      this._profilephoto = profilephoto;
    }
    if (foldername != null) {
      this._foldername = foldername;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get fullname => _fullname;
  set fullname(String? fullname) => _fullname = fullname;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get dob => _dob;
  set dob(String? dob) => _dob = dob;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get bloodgroup => _bloodgroup;
  set bloodgroup(String? bloodgroup) => _bloodgroup = bloodgroup;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get mobileno => _mobileno;
  set mobileno(String? mobileno) => _mobileno = mobileno;
  String? get maritalstatus => _maritalstatus;
  set maritalstatus(String? maritalstatus) => _maritalstatus = maritalstatus;
  String? get currentaddress => _currentaddress;
  set currentaddress(String? currentaddress) => _currentaddress = currentaddress;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get statename => _statename;
  set statename(String? statename) => _statename = statename;
  String? get postalcode => _postalcode;
  set postalcode(String? postalcode) => _postalcode = postalcode;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get addressid => _addressid;
  set addressid(String? addressid) => _addressid = addressid;
  String? get aboutme => _aboutme;
  set aboutme(String? aboutme) => _aboutme = aboutme;
  String? get profilephoto => _profilephoto;
  set profilephoto(String? profilephoto) => _profilephoto = profilephoto;
  String? get foldername => _foldername;
  set foldername(String? foldername) => _foldername = foldername;

  ProviderProfileResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fullname = json['fullname'];
    _username = json['username'];
    _dob = json['dob'];
    _gender = json['gender'];
    _bloodgroup = json['bloodgroup'];
    _email = json['email'];
    _mobileno = json['mobileno'];
    _maritalstatus = json['maritalstatus'];
    _currentaddress = json['currentaddress'];
    _city = json['city'];
    _statename = json['statename'];
    _postalcode = json['postalcode'];
    _country = json['country'];
    _addressid = json['addressid'];
    _aboutme = json['aboutme'];
    _profilephoto = json['profilephoto'];
    _foldername = json['foldername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fullname'] = this._fullname;
    data['username'] = this._username;
    data['dob'] = this._dob;
    data['gender'] = this._gender;
    data['bloodgroup'] = this._bloodgroup;
    data['email'] = this._email;
    data['mobileno'] = this._mobileno;
    data['maritalstatus'] = this._maritalstatus;
    data['currentaddress'] = this._currentaddress;
    data['city'] = this._city;
    data['statename'] = this._statename;
    data['postalcode'] = this._postalcode;
    data['country'] = this._country;
    data['addressid'] = this._addressid;
    data['aboutme'] = this._aboutme;
    data['profilephoto'] = this._profilephoto;
    data['foldername'] = this._foldername;
    return data;
  }
}
