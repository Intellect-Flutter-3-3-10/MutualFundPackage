class GetMutualFundOverviewModel {
  bool? status;
  String? message;
  Data? data;

  GetMutualFundOverviewModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetMutualFundOverviewModel.fromJson(Map<String, dynamic> json) => GetMutualFundOverviewModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };

  GetMutualFundOverviewModel copyWith({
    bool? status,
    String? message,
    bool? isInWatchList,
    Data? data,
  }) {
    return GetMutualFundOverviewModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class Data {
  bool? isInWatchlist;
  int? id;
  int? schemeCode;
  String? schemeName;
  String? riskCategory;
  String? assetClass;
  String? schemeCategory;
  String? fundManager;
  double? nav;
  DateTime? navDate;
  double? oneWeekChange;
  double? oneWeekReturn;
  double? sinceInceptionReturn;
  String? amcIcon;
  String? investmentObjective;
  double? expenseRatio;
  DateTime? launchDate;
  int? sipMinimum;
  int? lumpsumMinimum;
  String? isin;
  double? beta;
  String? lockIn;
  double? sharpeRatio;
  dynamic benchmark;
  String? rtaamcCode;
  String? rtaCode;
  double? aum;
  String? rating;
  String? annualisedStdDev;
  List<HistoricalNavDetail>? historicalNavDetails;
  List<ChartPeriod>? chartPeriods;

  Data({
    this.isInWatchlist = false,
    this.id,
    this.schemeCode,
    this.schemeName,
    this.riskCategory,
    this.assetClass,
    this.schemeCategory,
    this.fundManager,
    this.nav,
    this.navDate,
    this.oneWeekChange,
    this.oneWeekReturn,
    this.sinceInceptionReturn,
    this.amcIcon,
    this.investmentObjective,
    this.expenseRatio,
    this.launchDate,
    this.sipMinimum,
    this.lumpsumMinimum,
    this.isin,
    this.beta,
    this.lockIn,
    this.sharpeRatio,
    this.benchmark,
    this.rtaamcCode,
    this.rtaCode,
    this.aum,
    this.rating = '',
    this.annualisedStdDev,
    this.historicalNavDetails,
    this.chartPeriods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isInWatchlist: json["isInWatchlist"],
        id: json["id"],
        schemeCode: json["schemeCode"],
        schemeName: json["schemeName"],
        riskCategory: json["riskCategory"],
        assetClass: json["assetClass"],
        schemeCategory: json["schemeCategory"],
        fundManager: json["fundManager"],
        nav: json["nav"]?.toDouble(),
        navDate: DateTime.parse(json["navDate"]),
        oneWeekChange: json["oneWeekChange"]?.toDouble(),
        oneWeekReturn: json["oneWeekReturn"]?.toDouble(),
        sinceInceptionReturn: json["sinceInceptionReturn"]?.toDouble(),
        amcIcon: json["amcIcon"],
        investmentObjective: json["investmentObjective"],
        expenseRatio: json["expenseRatio"]?.toDouble(),
        launchDate: DateTime.parse(json["launchDate"]),
        sipMinimum: json["sipMinimum"],
        lumpsumMinimum: json["lumpsumMinimum"],
        isin: json["isin"],
        beta: json["beta"]?.toDouble(),
        lockIn: json["lockIn"],
        sharpeRatio: json["sharpeRatio"]?.toDouble(),
        benchmark: json["benchmark"],
        rtaamcCode: json["rtaamcCode"],
        rtaCode: json["rtaCode"],
        aum: json["aum"]?.toDouble(),
        rating: json["rating"],
        annualisedStdDev: json["annualisedStdDev"],
        historicalNavDetails: List<HistoricalNavDetail>.from(json["historicalNAVDetails"].map((x) => HistoricalNavDetail.fromJson(x))),
        chartPeriods: List<ChartPeriod>.from(json["chartPeriods"].map((x) => ChartPeriod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isInWatchlist": isInWatchlist,
        "id": id,
        "schemeCode": schemeCode,
        "schemeName": schemeName,
        "riskCategory": riskCategory,
        "assetClass": assetClass,
        "schemeCategory": schemeCategory,
        "fundManager": fundManager,
        "nav": nav,
        "navDate": navDate.toString(),
        "oneWeekChange": oneWeekChange,
        "oneWeekReturn": oneWeekReturn,
        "sinceInceptionReturn": sinceInceptionReturn,
        "amcIcon": amcIcon,
        "investmentObjective": investmentObjective,
        "expenseRatio": expenseRatio,
        "launchDate": launchDate.toString(),
        "sipMinimum": sipMinimum,
        "lumpsumMinimum": lumpsumMinimum,
        "isin": isin,
        "beta": beta,
        "lockIn": lockIn,
        "sharpeRatio": sharpeRatio,
        "benchmark": benchmark,
        "rtaamcCode": rtaamcCode,
        "rtaCode": rtaCode,
        "aum": aum,
        "rating": rating,
        "annualisedStdDev": annualisedStdDev,
        "historicalNAVDetails": List<dynamic>.from(historicalNavDetails!.map((x) => x.toJson())),
        "chartPeriods": List<dynamic>.from(chartPeriods!.map((x) => x.toJson())),
      };

  Data copyWith({
    bool? isInWatchlist,
    int? id,
    int? schemeCode,
    String? schemeName,
    String? riskCategory,
    String? assetClass,
    String? schemeCategory,
    String? fundManager,
    double? nav,
    DateTime? navDate,
    double? oneWeekChange,
    double? oneWeekReturn,
    double? sinceInceptionReturn,
    String? amcIcon,
    String? investmentObjective,
    double? expenseRatio,
    DateTime? launchDate,
    int? sipMinimum,
    int? lumpsumMinimum,
    String? isin,
    double? beta,
    String? lockIn,
    double? sharpeRatio,
    dynamic benchmark,
    String? rtaamcCode,
    String? rtaCode,
    double? aum,
    String? rating,
    bool? isInWatchList,
    String? annualisedStdDev,
    List<HistoricalNavDetail>? historicalNavDetails,
    List<ChartPeriod>? chartPeriods,
  }) {
    return Data(
      isInWatchlist: isInWatchlist ?? this.isInWatchlist,
      id: id ?? this.id,
      schemeCode: schemeCode ?? this.schemeCode,
      schemeName: schemeName ?? this.schemeName,
      riskCategory: riskCategory ?? this.riskCategory,
      assetClass: assetClass ?? this.assetClass,
      schemeCategory: schemeCategory ?? this.schemeCategory,
      fundManager: fundManager ?? this.fundManager,
      nav: nav ?? this.nav,
      navDate: navDate ?? this.navDate,
      oneWeekChange: oneWeekChange ?? this.oneWeekChange,
      oneWeekReturn: oneWeekReturn ?? this.oneWeekReturn,
      sinceInceptionReturn: sinceInceptionReturn ?? this.sinceInceptionReturn,
      amcIcon: amcIcon ?? this.amcIcon,
      investmentObjective: investmentObjective ?? this.investmentObjective,
      expenseRatio: expenseRatio ?? this.expenseRatio,
      launchDate: launchDate ?? this.launchDate,
      sipMinimum: sipMinimum ?? this.sipMinimum,
      lumpsumMinimum: lumpsumMinimum ?? this.lumpsumMinimum,
      isin: isin ?? this.isin,
      beta: beta ?? this.beta,
      lockIn: lockIn ?? this.lockIn,
      sharpeRatio: sharpeRatio ?? this.sharpeRatio,
      benchmark: benchmark ?? this.benchmark,
      rtaamcCode: rtaamcCode ?? this.rtaamcCode,
      rtaCode: rtaCode ?? this.rtaCode,
      aum: aum ?? this.aum,
      rating: rating ?? this.rating,
      annualisedStdDev: annualisedStdDev ?? this.annualisedStdDev,
      historicalNavDetails: historicalNavDetails ?? this.historicalNavDetails,
      chartPeriods: chartPeriods ?? this.chartPeriods,
    );
  }
}

class ChartPeriod {
  String periodId;
  String periodName;

  ChartPeriod({
    required this.periodId,
    required this.periodName,
  });

  factory ChartPeriod.fromJson(Map<String, dynamic> json) => ChartPeriod(
        periodId: json["periodId"],
        periodName: json["periodName"],
      );

  Map<String, dynamic> toJson() => {
        "periodId": periodId,
        "periodName": periodName,
      };

  ChartPeriod copyWith({
    String? periodId,
    String? periodName,
  }) {
    return ChartPeriod(
      periodId: periodId ?? this.periodId,
      periodName: periodName ?? this.periodName,
    );
  }
}

class HistoricalNavDetail {
  DateTime navDate;
  double nav;

  HistoricalNavDetail({
    required this.navDate,
    required this.nav,
  });

  factory HistoricalNavDetail.fromJson(Map<String, dynamic> json) => HistoricalNavDetail(
        navDate: DateTime.parse(json["navDate"]),
        nav: json["nav"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "navDate": navDate.toIso8601String(),
        "nav": nav,
      };

  HistoricalNavDetail copyWith({
    DateTime? navDate,
    double? nav,
  }) {
    return HistoricalNavDetail(
      navDate: navDate ?? this.navDate,
      nav: nav ?? this.nav,
    );
  }
}
