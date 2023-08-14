class TeamCountModel {
  bool result;
  String message;
  String lavel1;
  String lavel2;
  String lavel3;
  String lavel4;
  String lavel5;

  TeamCountModel(
      {this.result,
      this.message,
      this.lavel1,
      this.lavel2,
      this.lavel3,
      this.lavel4,
      this.lavel5});

  TeamCountModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    lavel1 = json['lavel_1'].toString();
    lavel2 = json['lavel_2'].toString();
    lavel3 = json['lavel_3'].toString();
    lavel4 = json['lavel_4'].toString();
    lavel5 = json['lavel_5'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['lavel_1'] = this.lavel1;
    data['lavel_2'] = this.lavel2;
    data['lavel_3'] = this.lavel3;
    data['lavel_4'] = this.lavel4;
    data['lavel_5'] = this.lavel5;
    return data;
  }
}
