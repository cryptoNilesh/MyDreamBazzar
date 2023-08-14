class TransactionHistoryModel {
  List<Data> data;

  TransactionHistoryModel({this.data});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int userId;
  int amount;
  String paymentMethod;
  String paymentDetails;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.userId,
      this.amount,
      this.paymentMethod,
      this.paymentDetails,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    paymentMethod = json['payment_method'].toString();
    paymentDetails = json['payment_details'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['payment_method'] = this.paymentMethod;
    data['payment_details'] = this.paymentDetails;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
