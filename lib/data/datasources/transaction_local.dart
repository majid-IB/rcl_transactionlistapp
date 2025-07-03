import '../models/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TransactionLocalDataSource {
  Future<void> saveTransactions(List<TransactionModel> transactions);
  Future<List<TransactionModel>> getTransactions();
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  static const String boxName = 'transactions';

  @override
  Future<void> saveTransactions(List<TransactionModel> transactions) async {
    final box = await Hive.openBox(boxName);
    final transactionsJson = transactions.map((t) => t.toJson()).toList();
    await box.put('transactions', transactionsJson);
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final box = await Hive.openBox(boxName);
    final data = box.get('transactions') as List<dynamic>?;
    if (data != null) {
      return data.map((json) => TransactionModel.fromJson(Map<String, dynamic>.from(json))).toList();
    }
    return [];
  }
}