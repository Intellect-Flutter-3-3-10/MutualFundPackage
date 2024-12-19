class AddToWatchLisModel {
  String? watchListName;
  List<String>? schemeCodes;
  String? userId;

  AddToWatchLisModel({this.watchListName, this.schemeCodes, this.userId});

  AddToWatchLisModel.fromJson(Map<String, dynamic> json) {
    watchListName = json['watchListName'];
    schemeCodes = json['schemeCodes'].cast<String>();
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['watchListName'] = this.watchListName;
    data['schemeCodes'] = this.schemeCodes;
    data['userId'] = this.userId;
    return data;
  }
}
