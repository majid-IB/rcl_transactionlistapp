
import 'package:equatable/equatable.dart';

import '../../../domain/entites/transactions.dart';


abstract class TransactionDetailsState extends Equatable {
  const TransactionDetailsState();

  @override
  List<Object> get props => [];
}

class TransactionDetailsInitial extends TransactionDetailsState {}

class TransactionDetailsLoading extends TransactionDetailsState {}

class TransactionDetailsLoaded extends TransactionDetailsState {
  final Transaction transaction;
  final String language;
  final bool isDarkTheme;

  const TransactionDetailsLoaded({
    required this.transaction,
    required this.language,
    required this.isDarkTheme,
  });

  @override
  List<Object> get props => [transaction, language, isDarkTheme];

  TransactionDetailsLoaded copyWith({
    Transaction? transaction,
    String? language,
    bool? isDarkTheme,
  }) {
    return TransactionDetailsLoaded(
      transaction: transaction ?? this.transaction,
      language: language ?? this.language,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}