import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/transaction_helper.dart';
import '../../domain/entites/transactions.dart';
import '../bloc/transactionDetailsBloc/transaction_details_bloc.dart';
import '../bloc/transactionDetailsBloc/transaction_details_event.dart';
import '../bloc/transactionDetailsBloc/transaction_details_state.dart';
import '../localization/app_localization.dart';
import '../widgets/details_widget.dart';
import '../widgets/loading_indicator.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsScreen({required this.transaction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TransactionDetailsBloc, TransactionDetailsState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          if (state is TransactionDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is! TransactionDetailsLoaded) {
            context.read<TransactionDetailsBloc>().add(
              LoadTransactionDetails(transaction),
            );
          }

          return TransactionDetailsView();
        },
      ),
    );
  }
}
class TransactionDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
          builder: (context, state) {
            String language = 'en';
            if (state is TransactionDetailsLoaded) {
              language = state.language;
            }
            return Text(AppLocalizations.translate('transaction_details', language));
          },
        ),
      ),
      body: BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
        builder: (context, state) {
          if (state is TransactionDetailsLoading) {
            return LoadingIndicator();
          }

          if (state is TransactionDetailsLoaded) {
            return DetailsWidget(
                state: state,);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}