
import '../entites/transactions.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<Transaction>> call({int page = 1, int limit = 10}) async {
    return await repository.getTransactions(page: page, limit: limit);
  }
}