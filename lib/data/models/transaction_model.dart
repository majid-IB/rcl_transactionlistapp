import '../../domain/entites/transactions.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required String id,
    required DateTime date,
    required double amount,
    required String type,
    required String merchant,
  }) : super(
    id: id,
    date: date,
    amount: amount,
    type: type,
    merchant: merchant,
  );

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: double.parse(json['amount'] as String),
      type: json['type'] as String,
      merchant: json['merchant'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount.toString(),
      'type': type,
      'merchant': merchant,
    };
  }
}