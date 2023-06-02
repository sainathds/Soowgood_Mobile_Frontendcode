import 'dart:io';

class ProviderEditDocumentRequest {
  String? id;
  String? file;
  String? documentname;
  String? userId;
  String? filetype;
  String? documentfilename;

  ProviderEditDocumentRequest({this.id, this.file, this.documentname, this.userId, this.filetype, this.documentfilename});

  ProviderEditDocumentRequest.fromJson(Map<String, dynamic> json) {
    this.id = json["Id"];
    this.file = json["File"];
    this.documentname = json["documentname"];
    this.userId = json["UserId"];
    this.filetype = json["filetype"];
    this.documentfilename = json["documentfilename"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Id"] = this.id;
    data["File"] = this.file;
    data["documentname"] = this.documentname;
    data["UserId"] = this.userId;
    data["filetype"] = this.filetype;
    data["documentfilename"] = this.documentfilename;
    return data;
  }
}