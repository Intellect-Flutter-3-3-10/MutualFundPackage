class AddOrderModel {
  String? clientCode;
  String? transactionCode;
  String? buySell;
  String? buySellType;
  String? dpType;
  String? schemeCode;
  int? amount;
  int? quantity;
  String? folioNumber;
  bool? allRedeem;
  String? remarks;

  AddOrderModel(
      {this.clientCode,
        this.transactionCode,
        this.buySell,
        this.buySellType,
        this.dpType,
        this.schemeCode,
        this.amount,
        this.quantity,
        this.folioNumber,
        this.allRedeem,
        this.remarks});

  AddOrderModel.fromJson(Map<String, dynamic> json) {
    clientCode = json['clientCode'];
    transactionCode = json['transactionCode'];
    buySell = json['buySell'];
    buySellType = json['buySellType'];
    dpType = json['dpType'];
    schemeCode = json['schemeCode'];
    amount = json['amount'];
    quantity = json['quantity'];
    folioNumber = json['folioNumber'];
    allRedeem = json['allRedeem'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientCode'] = this.clientCode;
    data['transactionCode'] = this.transactionCode;
    data['buySell'] = this.buySell;
    data['buySellType'] = this.buySellType;
    data['dpType'] = this.dpType;
    data['schemeCode'] = this.schemeCode;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['folioNumber'] = this.folioNumber;
    data['allRedeem'] = this.allRedeem;
    data['remarks'] = this.remarks;
    return data;
  }
}
