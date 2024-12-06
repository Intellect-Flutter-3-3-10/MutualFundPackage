import '../../my_app_exports.dart';

class MergedDataModel {
  final OrderData? orderData;
  final ScriptInfoModel? scriptInfo;

  // Fields from OrderData
  String? schemeCode;
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
  double? expenseRatio;

  // Fields from ScriptInfoModel
  String? exchange;
  int? uniqueNo;
  String? rtaSchemeCode;
  String? amcSchemeCode;
  String? isinno;
  String? amcCode;
  String? schemeType;
  String? schemePlan;
  double? minimumPurchaseAmount;
  double? additionalPurchaseAmountMultiple;
  double? maximumPurchaseAmount;
  String? dividendReinvestmentFlag;
  String? sipFlag;
  String? stpFlag;
  String? swpFlag;
  String? switchFlag;
  String? settlementType;
  String? startDate;
  String? exitLoadFlag;
  int? exitLoad;
  String? lockinPeriodFlag;
  int? lockinPeriod;
  String? channelPartnerCode;

  // Constructor
  MergedDataModel({
    this.scriptInfo,
    this.orderData,
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
    this.expenseRatio,
    this.exchange,
    this.uniqueNo,
    this.rtaSchemeCode,
    this.amcSchemeCode,
    this.isinno,
    this.amcCode,
    this.schemeType,
    this.schemePlan,
    this.minimumPurchaseAmount,
    this.additionalPurchaseAmountMultiple,
    this.maximumPurchaseAmount,
    this.dividendReinvestmentFlag,
    this.sipFlag,
    this.stpFlag,
    this.swpFlag,
    this.switchFlag,
    this.settlementType,
    this.startDate,
    this.exitLoadFlag,
    this.exitLoad,
    this.lockinPeriodFlag,
    this.lockinPeriod,
    this.channelPartnerCode,
  });

  // fromJson Method
  factory MergedDataModel.fromJson(Map<String, dynamic> json) {
    return MergedDataModel(
      orderData: json['orderData'] != null ? OrderData.fromJson(json['orderData']) : null,
      scriptInfo: json['scriptInfo'] != null ? ScriptInfoModel.fromJson(json['scriptInfo']) : null,
      schemeCode: json['schemeCode'],
      schemeName: json['schemeName'],
      riskCategory: json['riskCategory'],
      assetClass: json['assetClass'],
      schemeCategory: json['schemeCategory'],
      aum: json['aum']?.toDouble(),
      oneWeek: json['oneWeek']?.toDouble(),
      oneMonth: json['oneMonth']?.toDouble(),
      threeMonth: json['threeMonth']?.toDouble(),
      sixMonth: json['sixMonth']?.toDouble(),
      oneYear: json['oneYear']?.toDouble(),
      threeYear: json['threeYear']?.toDouble(),
      fiveYear: json['fiveYear']?.toDouble(),
      tenYear: json['tenYear']?.toDouble(),
      sinceInception: json['sinceInception']?.toDouble(),
      rating: json['rating'],
      amcIcon: json['amcIcon'],
      expenseRatio: json['expenseRatio']?.toDouble(),
      exchange: json['exchange'],
      uniqueNo: json['uniqueNo'],
      rtaSchemeCode: json['rtaSchemeCode'],
      amcSchemeCode: json['amcSchemeCode'],
      isinno: json['isinno'],
      amcCode: json['amcCode'],
      schemeType: json['schemeType'],
      schemePlan: json['schemePlan'],
      minimumPurchaseAmount: json['minimumPurchaseAmount']?.toDouble(),
      additionalPurchaseAmountMultiple: json['additionalPurchaseAmountMultiple']?.toDouble(),
      maximumPurchaseAmount: json['maximumPurchaseAmount']?.toDouble(),
      dividendReinvestmentFlag: json['dividendReinvestmentFlag'],
      sipFlag: json['sipFlag'],
      stpFlag: json['stpFlag'],
      swpFlag: json['swpFlag'],
      switchFlag: json['switchFlag'],
      settlementType: json['settlementType'],
      startDate: json['startDate'],
      exitLoadFlag: json['exitLoadFlag'],
      exitLoad: json['exitLoad'],
      lockinPeriodFlag: json['lockinPeriodFlag'],
      lockinPeriod: json['lockinPeriod'],
      channelPartnerCode: json['channelPartnerCode'],
    );
  }

  // toJson Method
  Map<String, dynamic> toJson() {
    return {
      'orderData': orderData?.toJson(),
      'scriptInfo': scriptInfo?.toJson(),
      'schemeCode': schemeCode,
      'schemeName': schemeName,
      'riskCategory': riskCategory,
      'assetClass': assetClass,
      'schemeCategory': schemeCategory,
      'aum': aum,
      'oneWeek': oneWeek,
      'oneMonth': oneMonth,
      'threeMonth': threeMonth,
      'sixMonth': sixMonth,
      'oneYear': oneYear,
      'threeYear': threeYear,
      'fiveYear': fiveYear,
      'tenYear': tenYear,
      'sinceInception': sinceInception,
      'rating': rating,
      'amcIcon': amcIcon,
      'expenseRatio': expenseRatio,
      'exchange': exchange,
      'uniqueNo': uniqueNo,
      'rtaSchemeCode': rtaSchemeCode,
      'amcSchemeCode': amcSchemeCode,
      'isinno': isinno,
      'amcCode': amcCode,
      'schemeType': schemeType,
      'schemePlan': schemePlan,
      'minimumPurchaseAmount': minimumPurchaseAmount,
      'additionalPurchaseAmountMultiple': additionalPurchaseAmountMultiple,
      'maximumPurchaseAmount': maximumPurchaseAmount,
      'dividendReinvestmentFlag': dividendReinvestmentFlag,
      'sipFlag': sipFlag,
      'stpFlag': stpFlag,
      'swpFlag': swpFlag,
      'switchFlag': switchFlag,
      'settlementType': settlementType,
      'startDate': startDate,
      'exitLoadFlag': exitLoadFlag,
      'exitLoad': exitLoad,
      'lockinPeriodFlag': lockinPeriodFlag,
      'lockinPeriod': lockinPeriod,
      'channelPartnerCode': channelPartnerCode,
    };
  }
}
