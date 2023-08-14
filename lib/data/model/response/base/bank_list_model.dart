class BankListModel {
  List<Data> data;

  BankListModel({this.data});

  BankListModel.fromJson(Map<String, dynamic> json) {
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
  String accountName;
  String accountNumber;
  String ifsc;
  String extra;
  String extra2;
  String date;
  String time;
  String createAt;

  Data(
      {this.id,
      this.userId,
      this.accountName,
      this.accountNumber,
      this.ifsc,
      this.extra,
      this.extra2,
      this.date,
      this.time,
      this.createAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    extra = json['extra'];
    extra2 = json['extra2'];
    date = json['date'];
    time = json['time'];
    createAt = json['create_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['extra'] = this.extra;
    data['extra2'] = this.extra2;
    data['date'] = this.date;
    data['time'] = this.time;
    data['create_at'] = this.createAt;
    return data;
  }
}
