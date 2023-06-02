
class GetPatientDocumentHistoryRequest {
  String? serviceReceiverId;
  String? booingId;

  GetPatientDocumentHistoryRequest({this.serviceReceiverId, this.booingId});

  GetPatientDocumentHistoryRequest.fromJson(Map<String, dynamic> json) {
    serviceReceiverId = json["serviceReceiverId"];
    booingId = json["booingId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["serviceReceiverId"] = serviceReceiverId;
    _data["booingId"] = booingId;
    return _data;
  }
}