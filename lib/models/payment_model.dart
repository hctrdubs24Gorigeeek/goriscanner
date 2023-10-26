import 'dart:convert';

class PaymentModel {
  String message;
  double? amount;
  double? fee;
  double? total;

  PaymentModel({
    required this.message,
    this.amount,
    this.fee,
    this.total,
  });

  PaymentModel copyWith({
    String? message,
    double? amount,
    double? fee,
    double? total,
  }) =>
      PaymentModel(
        message: message ?? this.message,
        amount: amount ?? this.amount,
        fee: fee ?? this.fee,
        total: total ?? this.total,
      );

  factory PaymentModel.fromJson(String str) =>
      PaymentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromMap(Map<String, dynamic> json) => PaymentModel(
        message: json["message"],
        amount: json["amount"]?.toDouble(),
        fee: json["fee"]?.toDouble(),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "amount": amount,
        "fee": fee,
        "total": total,
      };
}
