

import 'package:equatable/equatable.dart';

import '../../../domain/entites/transactions.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final bool isOffline;
  final String language;
  final bool isDarkTheme;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final int currentPage;

  const TransactionLoaded({
    required this.transactions,
    required this.isOffline,
    required this.language,
    required this.isDarkTheme,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [
    transactions,
    isOffline,
    language,
    isDarkTheme,
    isLoadingMore,
    hasReachedMax,
    currentPage,
  ];

  TransactionLoaded copyWith({
    List<Transaction>? transactions,
    bool? isOffline,
    String? language,
    bool? isDarkTheme,
    bool? isLoadingMore,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return TransactionLoaded(
      transactions: transactions ?? this.transactions,
      isOffline: isOffline ?? this.isOffline,
      language: language ?? this.language,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}