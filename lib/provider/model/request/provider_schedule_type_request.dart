class ProviderScheduleTypeRequest {
  String? userId;

  ProviderScheduleTypeRequest({this.userId});

  ProviderScheduleTypeRequest.fromJson(Map<String, dynamic> json) {
    this.userId = json["UserId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["UserId"] = this.userId;
    return data;
  }
}