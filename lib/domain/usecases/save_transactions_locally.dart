
import '../entites/transactions.dart';
import '../repositories/transaction_repository.dart';

class SaveTransactionsLocally {
  final TransactionRepository repository;

  SaveTransactionsLocally(this.repository);

  Future<void> call(List<Transaction> transactions) async {
    return await repository.saveTransactionsLocally(transactions);
  }
}