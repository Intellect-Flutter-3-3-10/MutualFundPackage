class GetOrdersModel {
  bool? status;
  String? message;
  List<OrderData>? data;

  GetOrdersModel({this.status, this.message, this.data});

  GetOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(new OrderData.fromJson(v));
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

class OrderData {
  int? id;
  String? clientCode;
  String? transactionCode;
  String? buySell;
  String? buySellType;
  bool? allRedeem;
  String? schemeCode;
  String? dpType;
  double? amount;
  int? quantity;
  String? folioNumber;
  String? remarks;
  int? vendorCode;
  String? createAt;
  String? userId;
  String? recordType;
  String? transactionNumber;
  String? exchMessage;
  String? orderId;
  String? frequencyType;
  double? installmentAmount;
  int? noOfInstallment;

  OrderData(
      {this.id,
      this.clientCode,
      this.transactionCode,
      this.buySell,
      this.buySellType,
      this.allRedeem,
      this.schemeCode,
      this.dpType,
      this.amount,
      this.quantity,
      this.folioNumber,
      this.remarks,
      this.vendorCode,
      this.createAt,
      this.userId,
      this.recordType,
      this.transactionNumber,
      this.exchMessage,
      this.orderId,
      this.frequencyType,
      this.installmentAmount,
      this.noOfInstallment});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientCode = json['clientCode'];
    transactionCode = json['transactionCode'];
    buySell = json['buySell'];
    buySellType = json['buySellType'];
    allRedeem = json['allRedeem'];
    schemeCode = json['schemeCode'];
    dpType = json['dpType'];
    amount = json['amount'];
    quantity = json['quantity'];
    folioNumber = json['folioNumber'];
    remarks = json['remarks'];
    vendorCode = json['vendorCode'];
    createAt = json['createAt'];
    userId = json['userId'];
    recordType = json['recordType'];
    transactionNumber = json['transactionNumber'];
    exchMessage = json['exchMessage'];
    orderId = json['orderId'];
    frequencyType = json['frequencyType'];
    installmentAmount = json['installmentAmount'];
    noOfInstallment = json['noOfInstallment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clientCode'] = this.clientCode;
    data['transactionCode'] = this.transactionCode;
    data['buySell'] = this.buySell;
    data['buySellType'] = this.buySellType;
    data['allRedeem'] = this.allRedeem;
    data['schemeCode'] = this.schemeCode;
    data['dpType'] = this.dpType;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['folioNumber'] = this.folioNumber;
    data['remarks'] = this.remarks;
    data['vendorCode'] = this.vendorCode;
    data['createAt'] = this.createAt;
    data['userId'] = this.userId;
    data['recordType'] = this.recordType;
    data['transactionNumber'] = this.transactionNumber;
    data['exchMessage'] = this.exchMessage;
    data['orderId'] = this.orderId;
    data['frequencyType'] = this.frequencyType;
    data['installmentAmount'] = this.installmentAmount;
    data['noOfInstallment'] = this.noOfInstallment;
    return data;
  }
}
