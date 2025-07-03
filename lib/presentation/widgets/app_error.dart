
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/transactionBloc/transaction_bloc.dart';
import '../bloc/transactionBloc/transaction_event.dart';
import '../localization/app_localization.dart';

class AppError extends StatelessWidget {
  final String message;

  const AppError({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            '${AppLocalizations.translate('error', 'en')}: $message',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<TransactionBloc>().add(InitializeAppSettings()),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}