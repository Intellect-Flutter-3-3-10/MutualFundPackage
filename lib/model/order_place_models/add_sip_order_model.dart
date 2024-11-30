class AddSipOrderModel {
  String? clientCode;
  String? transactionCode;
  String? dpType;
  String? purchaseType;
  String? schemeCode;
  String? folioNumber;
  String? remarks;
  String? startDate;
  String? frequencyType;
  String? installmentAmount;
  String? noOfIntellments;

  AddSipOrderModel(
      {this.clientCode,
        this.transactionCode,
        this.dpType,
        this.purchaseType,
        this.schemeCode,
        this.folioNumber,
        this.remarks,
        this.startDate,
        this.frequencyType,
        this.installmentAmount,
        this.noOfIntellments});

  AddSipOrderModel.fromJson(Map<String, dynamic> json) {
    clientCode = json['ClientCode'];
    transactionCode = json['transactionCode'];
    dpType = json['dpType'];
    purchaseType = json['PurchaseType'];
    schemeCode = json['SchemeCode'];
    folioNumber = json['FolioNumber'];
    remarks = json['Remarks'];
    startDate = json['StartDate'];
    frequencyType = json['FrequencyType'];
    installmentAmount = json['InstallmentAmount'];
    noOfIntellments = json['NoOfIntellments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientCode'] = this.clientCode;
    data['transactionCode'] = this.transactionCode;
    data['dpType'] = this.dpType;
    data['PurchaseType'] = this.purchaseType;
    data['SchemeCode'] = this.schemeCode;
    data['FolioNumber'] = this.folioNumber;
    data['Remarks'] = this.remarks;
    data['StartDate'] = this.startDate;
    data['FrequencyType'] = this.frequencyType;
    data['InstallmentAmount'] = this.installmentAmount;
    data['NoOfIntellments'] = this.noOfIntellments;
    return data;
  }
}
