import 'package:rcl_transactionlistapp/core/constants.dart';

import '../models/transaction_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions({int page = 1, int limit = 10});
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final http.Client client;
  final String baseUrl = AppConstants.transBaseurl;

  TransactionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TransactionModel>> getTransactions({int page = 1, int limit = 10}) async {
    final response = await client.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}