class ProviderAdminChargesRequest {
  String? userId;

  ProviderAdminChargesRequest({this.userId});

  ProviderAdminChargesRequest.fromJson(Map<String, dynamic> json) {
    this.userId = json["UserId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["UserId"] = this.userId;
    return data;
  }
}