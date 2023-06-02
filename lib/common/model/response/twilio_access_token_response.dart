
class TwilioAccessTokenResponse {
  String? token;

  TwilioAccessTokenResponse({this.token});

  TwilioAccessTokenResponse.fromJson(Map<dynamic, dynamic> json) {
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["token"] = token;
    return _data;
  }
}