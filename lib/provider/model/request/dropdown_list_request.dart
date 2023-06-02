class DropdownListRequest {
  String? searchKeyword;

  DropdownListRequest({this.searchKeyword});

  DropdownListRequest.fromJson(Map<String, dynamic> json) {
    this.searchKeyword = json["SearchKeyword"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["SearchKeyword"] = this.searchKeyword;
    return data;
  }
}