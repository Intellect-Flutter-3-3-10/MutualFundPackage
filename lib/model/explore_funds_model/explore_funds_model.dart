class ExploreFundsModel {
  bool? status;
  String? message;
  List<FundData>? data;

  ExploreFundsModel({this.status, this.message, this.data});

  ExploreFundsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FundData>[];
      json['data'].forEach((v) {
        data!.add(new FundData.fromJson(v));
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

class FundData {
  int? id;
  num? schemeCode;
  String? schemeName;
  String? riskCategory;
  String? assetClass;
  String? schemeCategory;
  num? aum;
  num? oneWeek;
  num? oneMonth;
  num? threeMonth;
  num? sixMonth;
  num? oneYear;
  num? threeYear;
  num? fiveYear;
  num? tenYear;
  num? sinceInception;
  num? rating;
  String? amcIcon;
  num? totalRecords;
  num? totalPages;
  num? expenseRatio;
  bool? isInWatchList;
  dynamic rtaamcCode;
  dynamic rtaCode;

  FundData({
    this.id,
    this.schemeCode,
    this.schemeName,
    this.riskCategory,
    this.assetClass,
    this.schemeCategory,
    this.aum,
    this.oneWeek,
    this.oneMonth,
    this.threeMonth,
    this.sixMonth,
    this.oneYear,
    this.threeYear,
    this.fiveYear,
    this.tenYear,
    this.sinceInception,
    this.rating,
    this.amcIcon,
    this.totalRecords,
    this.totalPages,
    this.expenseRatio,
    this.rtaamcCode,
    this.rtaCode,
    this.isInWatchList,
  });

  FundData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schemeCode = json['schemeCode'];
    schemeName = json['schemeName'];
    riskCategory = json['riskCategory'];
    assetClass = json['assetClass'];
    schemeCategory = json['schemeCategory'];
    aum = json['aum'];
    oneWeek = json['oneWeek'];
    oneMonth = json['oneMonth'];
    threeMonth = json['threeMonth'];
    sixMonth = json['sixMonth'];
    oneYear = json['oneYear'];
    threeYear = json['threeYear'];
    fiveYear = json['fiveYear'];
    tenYear = json['tenYear'];
    sinceInception = json['sinceInception'];
    rating = json['rating'];
    amcIcon = json['amcIcon'];
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
    expenseRatio = json['expenseRatio'];
    rtaamcCode = json['rtaamcCode'];
    rtaCode = json['rtaCode'];
    isInWatchList = json['isInWatchList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schemeCode'] = this.schemeCode;
    data['schemeName'] = this.schemeName;
    data['riskCategory'] = this.riskCategory;
    data['assetClass'] = this.assetClass;
    data['schemeCategory'] = this.schemeCategory;
    data['aum'] = this.aum;
    data['oneWeek'] = this.oneWeek;
    data['oneMonth'] = this.oneMonth;
    data['threeMonth'] = this.threeMonth;
    data['sixMonth'] = this.sixMonth;
    data['oneYear'] = this.oneYear;
    data['threeYear'] = this.threeYear;
    data['fiveYear'] = this.fiveYear;
    data['tenYear'] = this.tenYear;
    data['sinceInception'] = this.sinceInception;
    data['rating'] = this.rating;
    data['amcIcon'] = this.amcIcon;
    data['totalRecords'] = this.totalRecords;
    data['totalPages'] = this.totalPages;
    data['expenseRatio'] = this.expenseRatio;
    data['rtaamcCode'] = this.rtaamcCode;
    data['rtaCode'] = this.rtaCode;
    data['isInWatchList'] = this.isInWatchList;
    return data;
  }

  FundData copyWith({
    int? id,
    num? schemeCode,
    String? schemeName,
    String? riskCategory,
    String? assetClass,
    String? schemeCategory,
    num? aum,
    num? oneWeek,
    num? oneMonth,
    num? threeMonth,
    num? sixMonth,
    num? oneYear,
    num? threeYear,
    num? fiveYear,
    num? tenYear,
    num? sinceInception,
    num? rating,
    String? amcIcon,
    num? totalRecords,
    num? totalPages,
    num? expenseRatio,
    bool? isInWatchList,
    dynamic rtaamcCode,
    dynamic rtaCode,
  }) {
    return FundData(
      id: id ?? this.id,
      schemeCode: schemeCode ?? this.schemeCode,
      schemeName: schemeName ?? this.schemeName,
      riskCategory: riskCategory ?? this.riskCategory,
      assetClass: assetClass ?? this.assetClass,
      schemeCategory: schemeCategory ?? this.schemeCategory,
      aum: aum ?? this.aum,
      oneWeek: oneWeek ?? this.oneWeek,
      oneMonth: oneMonth ?? this.oneMonth,
      threeMonth: threeMonth ?? this.threeMonth,
      sixMonth: sixMonth ?? this.sixMonth,
      oneYear: oneYear ?? this.oneYear,
      threeYear: threeYear ?? this.threeYear,
      fiveYear: fiveYear ?? this.fiveYear,
      tenYear: tenYear ?? this.tenYear,
      sinceInception: sinceInception ?? this.sinceInception,
      rating: rating ?? this.rating,
      amcIcon: amcIcon ?? this.amcIcon,
      totalRecords: totalRecords ?? this.totalRecords,
      totalPages: totalPages ?? this.totalPages,
      expenseRatio: expenseRatio ?? this.expenseRatio,
      rtaamcCode: rtaamcCode ?? this.rtaamcCode,
      rtaCode: rtaCode ?? this.rtaCode,
      isInWatchList: isInWatchList ?? this.isInWatchList,
    );
  }
}
