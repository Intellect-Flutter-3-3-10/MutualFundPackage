class ExploreFundsModel {
  int? schemeCode;
  String? schemeName;
  String? riskCategory;
  String? assetClass;
  String? schemeCategory;
  double? aum;
  double? oneWeek;
  double? oneMonth;
  double? threeMonth;
  double? sixMonth;
  double? oneYear;
  double? threeYear;
  double? fiveYear;
  double? tenYear;
  double? sinceInception;
  int? rating;
  String? amcIcon;
  int? totalRecords;
  int? totalPages;
  double? expenseRatio;

  ExploreFundsModel({
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
  });

  factory ExploreFundsModel.fromJson(Map<String, dynamic> json) {
    return ExploreFundsModel(
      schemeCode: json['SchemeCode'],
      schemeName: json['SchemeName'],
      riskCategory: json['RiskCategory'],
      assetClass: json['AssetClass'],
      schemeCategory: json['SchemeCategory'],
      aum: json['AUM'],
      oneWeek: json['OneWeek'],
      oneMonth: json['OneMonth'],
      threeMonth: json['ThreeMonth'],
      sixMonth: json['SixMonth'],
      oneYear: json['OneYear'],
      threeYear: json['ThreeYear'],
      fiveYear: json['FiveYear'],
      tenYear: json['TenYear'],
      sinceInception: json['SinceInception'],
      rating: json['Rating'],
      amcIcon: json['AMCIcon'],
      totalRecords: json['TotalRecords'],
      totalPages: json['TotalPages'],
      expenseRatio: json['ExpenseRatio'],
    );
  }
}
