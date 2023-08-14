// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TransactionModel transactionModelFromMap(String str) =>
    TransactionModel.fromMap(json.decode(str));

String transactionModelToMap(TransactionModel data) =>
    json.encode(data.toMap());

class TransactionModel {
  TransactionModel({
    @required this.data,
  });

  List<Datum> data;

  factory TransactionModel.fromMap(Map<String, dynamic> json) =>
      TransactionModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    @required this.id,
    @required this.userId,
    @required this.amount,
    @required this.paymentMethod,
    @required this.paymentDetails,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  int userId;
  int amount;
  dynamic paymentMethod;
  dynamic paymentDetails;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        paymentDetails: json["payment_details"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "amount": amount,
        "payment_method": paymentMethod,
        "payment_details": paymentDetails,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
