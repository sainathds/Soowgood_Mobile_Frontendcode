class UploadProfilePicRequest {
  String? _file;
  String? _id;

  UploadProfilePicRequest({String? file, String? id}) {
    if (file != null) {
      this._file = file;
    }
    if (id != null) {
      this._id = id;
    }
  }

  String? get file => _file;
  set file(String? file) => _file = file;
  String? get id => _id;
  set id(String? id) => _id = id;

  UploadProfilePicRequest.fromJson(Map<String, dynamic> json) {
    _file = json['File'];
    _id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['File'] = this._file;
    data['Id'] = this._id;
    return data;
  }
}
