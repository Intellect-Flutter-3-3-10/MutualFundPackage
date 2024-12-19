class GetWatchListDataModel {
  bool? status;
  String? message;
  List<WatchListData>? data;

  GetWatchListDataModel({this.status, this.message, this.data});

  GetWatchListDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WatchListData>[];
      json['data'].forEach((v) {
        data!.add(new WatchListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WatchListData {
  int? id;
  List<String>? schemeCodes;
  String? watchListName;
  String? userId;
  String? createdAt;
  String? updatedAt;

  WatchListData({this.id, this.schemeCodes, this.watchListName, this.userId, this.createdAt, this.updatedAt});

  WatchListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schemeCodes = json['schemeCodes'].cast<String>();
    watchListName = json['watchListName'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schemeCodes'] = this.schemeCodes;
    data['watchListName'] = this.watchListName;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
