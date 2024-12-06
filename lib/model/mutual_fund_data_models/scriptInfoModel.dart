class ScriptInfoModel {
  String? exchange;
  int? uniqueNo;
  String? schemeCode;
  String? rtaSchemeCode;
  String? amcSchemeCode;
  String? isinno;
  String? amcCode;
  String? schemeType;
  String? schemePlan;
  String? schemeName;
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

  ScriptInfoModel({
    this.exchange,
    this.uniqueNo,
    this.schemeCode,
    this.rtaSchemeCode,
    this.amcSchemeCode,
    this.isinno,
    this.amcCode,
    this.schemeType,
    this.schemePlan,
    this.schemeName,
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

  // Factory method to parse CSV row data into a ScriptInfoModel object
  factory ScriptInfoModel.fromCsv(List<dynamic> row) {
    return ScriptInfoModel(
      exchange: row[0] as String?,
      uniqueNo: int.tryParse(row[1]?.toString() ?? '0'),
      schemeCode: row[2] as String?,
      rtaSchemeCode: row[3] as String?,
      amcSchemeCode: row[4] as String?,
      isinno: row[5] as String?,
      amcCode: row[6] as String?,
      schemeType: row[7] as String?,
      schemePlan: row[8] as String?,
      schemeName: row[9] as String?,
      minimumPurchaseAmount: double.tryParse(row[10]?.toString() ?? '0'),
      additionalPurchaseAmountMultiple: double.tryParse(row[11]?.toString() ?? '0'),
      maximumPurchaseAmount: double.tryParse(row[12]?.toString() ?? '0'),
      dividendReinvestmentFlag: row[13] as String?,
      sipFlag: row[14] as String?,
      stpFlag: row[15] as String?,
      swpFlag: row[16] as String?,
      switchFlag: row[17] as String?,
      settlementType: row[18] as String?,
      startDate: row[19] as String?,
      exitLoadFlag: row[20] as String?,
      exitLoad: int.tryParse(row[21]?.toString() ?? '0'),
      lockinPeriodFlag: row[22] as String?,
      lockinPeriod: int.tryParse(row[23]?.toString() ?? '0'),
      channelPartnerCode: row[24] as String?,
    );
  }

  // Factory method to parse a JSON object into a ScriptInfoModel instance
  factory ScriptInfoModel.fromJson(Map<String, dynamic> json) {
    return ScriptInfoModel(
      exchange: json['exchange'] as String?,
      uniqueNo: json['uniqueNo'] as int?,
      schemeCode: json['schemeCode'] as String?,
      rtaSchemeCode: json['rtaSchemeCode'] as String?,
      amcSchemeCode: json['amcSchemeCode'] as String?,
      isinno: json['isinno'] as String?,
      amcCode: json['amcCode'] as String?,
      schemeType: json['schemeType'] as String?,
      schemePlan: json['schemePlan'] as String?,
      schemeName: json['schemeName'] as String?,
      minimumPurchaseAmount: (json['minimumPurchaseAmount'] as num?)?.toDouble(),
      additionalPurchaseAmountMultiple: (json['additionalPurchaseAmountMultiple'] as num?)?.toDouble(),
      maximumPurchaseAmount: (json['maximumPurchaseAmount'] as num?)?.toDouble(),
      dividendReinvestmentFlag: json['dividendReinvestmentFlag'] as String?,
      sipFlag: json['sipFlag'] as String?,
      stpFlag: json['stpFlag'] as String?,
      swpFlag: json['swpFlag'] as String?,
      switchFlag: json['switchFlag'] as String?,
      settlementType: json['settlementType'] as String?,
      startDate: json['startDate'] as String?,
      exitLoadFlag: json['exitLoadFlag'] as String?,
      exitLoad: json['exitLoad'] as int?,
      lockinPeriodFlag: json['lockinPeriodFlag'] as String?,
      lockinPeriod: json['lockinPeriod'] as int?,
      channelPartnerCode: json['channelPartnerCode'] as String?,
    );
  }

  // Method to convert a ScriptInfoModel instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'exchange': exchange,
      'uniqueNo': uniqueNo,
      'schemeCode': schemeCode,
      'rtaSchemeCode': rtaSchemeCode,
      'amcSchemeCode': amcSchemeCode,
      'isinno': isinno,
      'amcCode': amcCode,
      'schemeType': schemeType,
      'schemePlan': schemePlan,
      'schemeName': schemeName,
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
