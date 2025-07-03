
import '../../domain/entites/transactions.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local.dart';
import '../datasources/transaction_remote.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Transaction>> getTransactions({int page = 1, int limit = 10}) async {
    try {
      final remoteTransactions = await remoteDataSource.getTransactions(page: page, limit: limit);

      if (page == 1) {
        await saveTransactionsLocally(remoteTransactions);
      } else {
        final existingTransactions = await getLocalTransactions();
        final allTransactions = [...existingTransactions, ...remoteTransactions];
        await saveTransactionsLocally(allTransactions);
      }

      return remoteTransactions;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<void> saveTransactionsLocally(List<Transaction> transactions) async {
    await localDataSource.saveTransactions(
      transactions.map((t) => TransactionModel(
        id: t.id,
        date: t.date,
        amount: t.amount,
        type: t.type,
        merchant: t.merchant,
      )).toList(),
    );
  }

  @override
  Future<List<Transaction>> getLocalTransactions() async {
    return await localDataSource.getTransactions();
  }
}