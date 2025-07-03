
import '../entites/transactions.dart';
import '../repositories/transaction_repository.dart';

class GetLocalTransactions {
  final TransactionRepository repository;

  GetLocalTransactions(this.repository);

  Future<List<Transaction>> call() async {
    return await repository.getLocalTransactions();
  }
}