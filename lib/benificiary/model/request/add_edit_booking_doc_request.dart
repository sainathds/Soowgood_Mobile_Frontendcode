class AddEditBookingDocRequest {
  String? bookingId;
  String? file;
  String? filetype;

  AddEditBookingDocRequest({this.bookingId, this.file, this.filetype});

  AddEditBookingDocRequest.fromJson(Map<String, dynamic> json) {
    bookingId = json["bookingId"];
    file = json["File"];
    filetype = json["filetype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["bookingId"] = bookingId;
    _data["File"] = file;
    _data["filetype"] = filetype;
    return _data;
  }
}