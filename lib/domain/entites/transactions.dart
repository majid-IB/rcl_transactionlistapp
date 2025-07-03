
import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final DateTime date;
  final double amount;
  final String type;
  final String merchant;

  const Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.merchant,
  });

  @override
  List<Object?> get props => [id, date, amount, type, merchant];
}