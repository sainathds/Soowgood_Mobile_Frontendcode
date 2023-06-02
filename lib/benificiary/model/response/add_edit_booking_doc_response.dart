import 'dart:convert';

List<AddEditBookingDocResponse> AddEditBookingDocResponseFromJsonList(dynamic str) => List<AddEditBookingDocResponse>.from(json.decode(str).map((x) => AddEditBookingDocResponse.fromJson(x)));

String AddEditBookingDocResponseToJsonList(List<AddEditBookingDocResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddEditBookingDocResponse {
  String? id;
  String? bookingid;
  String? filename;
  dynamic createdBy;
  String? createdOn;
  dynamic updatedBy;
  String? updatedOn;
  bool? isDeleted;
  bool? isActive;

  AddEditBookingDocResponse({this.id, this.bookingid, this.filename, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

  AddEditBookingDocResponse.fromJson(Map<dynamic, dynamic> json) {
    id = json["id"];
    bookingid = json["bookingid"];
    filename = json["filename"];
    createdBy = json["createdBy"];
    createdOn = json["createdOn"];
    updatedBy = json["updatedBy"];
    updatedOn = json["updatedOn"];
    isDeleted = json["isDeleted"];
    isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["bookingid"] = bookingid;
    _data["filename"] = filename;
    _data["createdBy"] = createdBy;
    _data["createdOn"] = createdOn;
    _data["updatedBy"] = updatedBy;
    _data["updatedOn"] = updatedOn;
    _data["isDeleted"] = isDeleted;
    _data["isActive"] = isActive;
    return _data;
  }
}