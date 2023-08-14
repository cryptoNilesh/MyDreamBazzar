class BalanceModel {
  Data data;

  BalanceModel({this.data});

  BalanceModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String wallet_repayment;
  String wallet_balance;

  Data({this.wallet_repayment, this.wallet_balance});

  Data.fromJson(Map<String, dynamic> json) {
    wallet_repayment = json['wallet_repayment']==null?"0":json['wallet_repayment'].toString();
    wallet_balance = json['wallet_balance']==null?"0":json['wallet_balance'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_repayment'] = this.wallet_repayment;
    data['wallet_balance'] = this.wallet_balance;
    return data;
  }
}
