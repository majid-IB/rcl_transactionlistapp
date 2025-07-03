import '../entites/transactions.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions({int page = 1, int limit = 10});
  Future<void> saveTransactionsLocally(List<Transaction> transactions);
  Future<List<Transaction>> getLocalTransactions();
}