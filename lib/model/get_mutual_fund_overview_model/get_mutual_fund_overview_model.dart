// To parse this JSON data, do
//
//     final getMutualFundOverviewModel = getMutualFundOverviewModelFromJson(jsonString);

import 'dart:convert';

GetMutualFundOverviewModel getMutualFundOverviewModelFromJson(String str) => GetMutualFundOverviewModel.fromJson(json.decode(str));

String getMutualFundOverviewModelToJson(GetMutualFundOverviewModel data) => json.encode(data.toJson());

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
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int schemeCode;
  String schemeName;
  String riskCategory;
  String assetClass;
  String schemeCategory;
  String fundManager;
  double nav;
  DateTime navDate;
  double oneWeekChange;
  double oneWeekReturn;
  double sinceInceptionReturn;
  String amcIcon;
  String investmentObjective;
  double expenseRatio;
  DateTime launchDate;
  int sipMinimum;
  int lumpsumMinimum;
  String isin;
  double beta;
  String lockIn;
  double sharpeRatio;
  dynamic benchmark;
  String rtaamcCode;
  String rtaCode;
  double aum;
  String annualisedStdDev;
  List<HistoricalNavDetail> historicalNavDetails;
  List<ChartPeriod> chartPeriods;

  Data({
    required this.schemeCode,
    required this.schemeName,
    required this.riskCategory,
    required this.assetClass,
    required this.schemeCategory,
    required this.fundManager,
    required this.nav,
    required this.navDate,
    required this.oneWeekChange,
    required this.oneWeekReturn,
    required this.sinceInceptionReturn,
    required this.amcIcon,
    required this.investmentObjective,
    required this.expenseRatio,
    required this.launchDate,
    required this.sipMinimum,
    required this.lumpsumMinimum,
    required this.isin,
    required this.beta,
    required this.lockIn,
    required this.sharpeRatio,
    required this.benchmark,
    required this.rtaamcCode,
    required this.rtaCode,
    required this.aum,
    required this.annualisedStdDev,
    required this.historicalNavDetails,
    required this.chartPeriods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        annualisedStdDev: json["annualisedStdDev"],
        historicalNavDetails: List<HistoricalNavDetail>.from(json["historicalNAVDetails"].map((x) => HistoricalNavDetail.fromJson(x))),
        chartPeriods: List<ChartPeriod>.from(json["chartPeriods"].map((x) => ChartPeriod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "schemeCode": schemeCode,
        "schemeName": schemeName,
        "riskCategory": riskCategory,
        "assetClass": assetClass,
        "schemeCategory": schemeCategory,
        "fundManager": fundManager,
        "nav": nav,
        "navDate": navDate.toIso8601String(),
        "oneWeekChange": oneWeekChange,
        "oneWeekReturn": oneWeekReturn,
        "sinceInceptionReturn": sinceInceptionReturn,
        "amcIcon": amcIcon,
        "investmentObjective": investmentObjective,
        "expenseRatio": expenseRatio,
        "launchDate": launchDate.toIso8601String(),
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
        "annualisedStdDev": annualisedStdDev,
        "historicalNAVDetails": List<dynamic>.from(historicalNavDetails.map((x) => x.toJson())),
        "chartPeriods": List<dynamic>.from(chartPeriods.map((x) => x.toJson())),
      };
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
}
