
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/transaction_helper.dart';
import '../bloc/transactionBloc/transaction_bloc.dart';
import '../bloc/transactionBloc/transaction_event.dart';
import '../bloc/transactionBloc/transaction_state.dart';
import '../bloc/transactionDetailsBloc/transaction_details_bloc.dart';
import '../localization/app_localization.dart';
import '../screens/transaction_details_screen.dart';

class TransactionList extends StatelessWidget {
  final ScrollController scrollController;
  final TransactionLoaded state;

  const TransactionList({
    required this.scrollController,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionBloc>().add(InitializeAppSettings());
      },
      child: ListView.builder(
        controller: scrollController,
        itemCount: state.transactions.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.transactions.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final transaction = state.transactions[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<TransactionDetailsBloc>(context),
                      child: TransactionDetailsScreen(
                        transaction: transaction,
                      ),
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: TransactionHelper.getColor(transaction.type),
                child: Text(
                  TransactionHelper.getAbbreviation(transaction.type),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                transaction.merchant,
                style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 14,),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${transaction.type}'),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${AppLocalizations.translate('date', state.language)}: ${transaction.date.day}-${transaction.date.month}-${transaction.date.year}'),
                  Text(
                    '\$${transaction.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TransactionHelper.getColor(transaction.type),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}