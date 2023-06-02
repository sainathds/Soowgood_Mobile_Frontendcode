import 'dart:convert';


List<ReadAllNotificationResponse> ReadAllNotificationResponseFromJsonList(dynamic str) => List<ReadAllNotificationResponse>.from(json.decode(str).map((x) => ReadAllNotificationResponse.fromJson(x)));

String ReadAllNotificationResponseToJsonList(List<ReadAllNotificationResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadAllNotificationResponse {
  String? id;
  String? notificationtext;
  int? isactive;
  String? userid;
  String? notificationtype;
  String? usertype;
  int? isread;
  int? isdeleted;
  int? showpopup;
  String? notificationdate;

  ReadAllNotificationResponse({this.id, this.notificationtext, this.isactive, this.userid, this.notificationtype, this.usertype, this.isread, this.isdeleted, this.showpopup, this.notificationdate});

  ReadAllNotificationResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    notificationtext = json["notificationtext"];
    isactive = json["isactive"];
    userid = json["userid"];
    notificationtype = json["notificationtype"];
    usertype = json["usertype"];
    isread = json["isread"];
    isdeleted = json["isdeleted"];
    showpopup = json["showpopup"];
    notificationdate = json["notificationdate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["notificationtext"] = notificationtext;
    _data["isactive"] = isactive;
    _data["userid"] = userid;
    _data["notificationtype"] = notificationtype;
    _data["usertype"] = usertype;
    _data["isread"] = isread;
    _data["isdeleted"] = isdeleted;
    _data["showpopup"] = showpopup;
    _data["notificationdate"] = notificationdate;
    return _data;
  }
}