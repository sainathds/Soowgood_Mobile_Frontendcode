import 'dart:convert';

List<BeneficiarySpecializationResponse> BeneficiarySpecializationResponseFromJsonList(dynamic str) => List<BeneficiarySpecializationResponse>.from(json.decode(str).map((x) => BeneficiarySpecializationResponse.fromJson(x)));

String BeneficiarySpecializationResponseToJsonList(List<BeneficiarySpecializationResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeneficiarySpecializationResponse {
  String? providerType;
  String? provider;
  dynamic imageUrl;

  BeneficiarySpecializationResponse({this.providerType, this.provider, this.imageUrl});

  BeneficiarySpecializationResponse.fromJson(Map<String, dynamic> json) {
    providerType = json["providerType"];
    provider = json["provider"];
    imageUrl = json["imageURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["providerType"] = providerType;
    _data["provider"] = provider;
    _data["imageURL"] = imageUrl;
    return _data;
  }
}