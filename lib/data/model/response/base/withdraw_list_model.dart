class WithdrawListModel {
  List<Data> data;

  WithdrawListModel({this.data});

  WithdrawListModel.fromJson(Map<String, dynamic> json) {
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
  String id;
  String userId;
  String status;
  String amount;
  String date;
  String time;
  String createdAt;
  String updateAt;

  Data(
      {this.id,
      this.userId,
      this.status,
      this.amount,
      this.date,
      this.time,
      this.createdAt,
      this.updateAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'];
    status = json['status'].toString();
    amount = json['amount'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
    updateAt = json['update_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
