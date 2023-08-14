class new_check_model {
  List<Data> data;
  String message;

  new_check_model({this.data, this.message});

  new_check_model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String name;
  String referId;
  String image;
  int referCount;
  List<Referals> referals;

  Data(
      {this.id,
        this.name,
        this.referId,
        this.image,
        this.referCount,
        this.referals});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    referId = json['refer_id'];
    image = json['image'];
    referCount = json['refer_count'];
    if (json['referals'] != null) {
      referals = <Referals>[];
      json['referals'].forEach((v) {
        referals.add(new Referals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['refer_id'] = this.referId;
    data['image'] = this.image;
    data['refer_count'] = this.referCount;
    if (this.referals != null) {
      data['referals'] = this.referals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Referals {
  int id;
  String name;
  String referId;
  int referCount;
  String image;
  List<Referals> referals;

  Referals({this.id, this.name, this.referId, this.referCount, this.image,this.referals});

  Referals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    referId = json['refer_id'];
    referCount = json['refer_count'];
    image = json['image'];
    if (json['referals'] != null) {
      referals = <Referals>[];
      json['referals'].forEach((v) {
        referals.add(new Referals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['refer_id'] = this.referId;
    data['refer_count'] = this.referCount;
    data['image'] = this.image;
    if (this.referals != null) {
      data['referals'] = this.referals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
