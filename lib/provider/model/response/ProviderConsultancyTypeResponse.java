
class ProviderConsultancyTypeResponse {
    String? id;
    String? name;
    String? note;
    dynamic createdBy;
    String? createdOn;
    dynamic updatedBy;
    String? updatedOn;
    bool? isDeleted;
    bool? isActive;

    ProviderConsultancyTypeResponse({this.id, this.name, this.note, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isDeleted, this.isActive});

    ProviderConsultancyTypeResponse.fromJson(Map<String, dynamic> json) {
        this.id = json["id"];
        this.name = json["name"];
        this.note = json["note"];
        this.createdBy = json["createdBy"];
        this.createdOn = json["createdOn"];
        this.updatedBy = json["updatedBy"];
        this.updatedOn = json["updatedOn"];
        this.isDeleted = json["isDeleted"];
        this.isActive = json["isActive"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = this.id;
        data["name"] = this.name;
        data["note"] = this.note;
        data["createdBy"] = this.createdBy;
        data["createdOn"] = this.createdOn;
        data["updatedBy"] = this.updatedBy;
        data["updatedOn"] = this.updatedOn;
        data["isDeleted"] = this.isDeleted;
        data["isActive"] = this.isActive;
        return data;
    }
}