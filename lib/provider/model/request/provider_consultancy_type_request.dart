
class ProviderConsultancyTypeRequest {
  String? id;

  ProviderConsultancyTypeRequest({this.id});

  ProviderConsultancyTypeRequest.fromJson(Map<String, dynamic> json) {
    this.id = json["Id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Id"] = this.id;
    return data;
  }
}