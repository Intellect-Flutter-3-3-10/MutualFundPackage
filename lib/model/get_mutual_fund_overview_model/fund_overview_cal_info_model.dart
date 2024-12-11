class FundOverviewCalInfoModel {
  bool? status;
  String? message;
  CalInfoData? data;

  FundOverviewCalInfoModel({this.status, this.message, this.data});

  FundOverviewCalInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CalInfoData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CalInfoData {
  String? schemeReturn;
  String? investmentPeriod;
  int? investedAmount;
  double? latestValue;
  double? wealthGained;
  double? scheme1YrReturn;
  double? bankFDReturn;
  double? gold1YrReturn;

  CalInfoData(
      {this.schemeReturn,
      this.investmentPeriod,
      this.investedAmount,
      this.latestValue,
      this.wealthGained,
      this.scheme1YrReturn,
      this.bankFDReturn,
      this.gold1YrReturn});

  CalInfoData.fromJson(Map<String, dynamic> json) {
    schemeReturn = json['schemeReturn'];
    investmentPeriod = json['investmentPeriod'];
    investedAmount = json['investedAmount'];
    latestValue = json['latestValue'];
    wealthGained = json['wealthGained'];
    scheme1YrReturn = json['scheme1YrReturn'];
    bankFDReturn = json['bankFDReturn'];
    gold1YrReturn = json['gold1YrReturn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schemeReturn'] = this.schemeReturn;
    data['investmentPeriod'] = this.investmentPeriod;
    data['investedAmount'] = this.investedAmount;
    data['latestValue'] = this.latestValue;
    data['wealthGained'] = this.wealthGained;
    data['scheme1YrReturn'] = this.scheme1YrReturn;
    data['bankFDReturn'] = this.bankFDReturn;
    data['gold1YrReturn'] = this.gold1YrReturn;
    return data;
  }
}
