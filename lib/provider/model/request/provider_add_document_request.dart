import 'dart:io';

class ProviderAddDocumentRequest {
  String? file;
  String? documentname;
  String? userId;
  String? filetype;

  ProviderAddDocumentRequest({this.file, this.documentname, this.userId, this.filetype});

  ProviderAddDocumentRequest.fromJson(Map<String, dynamic> json) {
    this.file = json["File"];
    this.documentname = json["documentname"];
    this.userId = json["UserId"];
    this.filetype = json["filetype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["File"] = this.file;
    data["documentname"] = this.documentname;
    data["UserId"] = this.userId;
    data["filetype"] = this.filetype;
    return data;
  }
}