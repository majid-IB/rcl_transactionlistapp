
import 'package:equatable/equatable.dart';

import '../../../domain/entites/transactions.dart';


abstract class TransactionDetailsEvent extends Equatable {
  const TransactionDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactionDetails extends TransactionDetailsEvent {
  final Transaction transaction;

  const LoadTransactionDetails(this.transaction);

  @override
  List<Object> get props => [transaction];
}