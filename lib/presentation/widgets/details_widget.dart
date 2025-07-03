import 'package:flutter/material.dart';

import '../bloc/transactionDetailsBloc/transaction_details_state.dart';
import '../localization/app_localization.dart';

class DetailsWidget extends StatelessWidget {
  final TransactionDetailsLoaded state;

  const DetailsWidget({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ll");
    final transaction = state.transaction;
    final language = state.language;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    AppLocalizations.translate('merchant', language),
                    transaction.merchant,
                  ),
                  _buildDetailRow(
                    AppLocalizations.translate('amount', language),
                    '\$${transaction.amount.toStringAsFixed(2)}',
                  ),
                  _buildDetailRow(
                    AppLocalizations.translate('type', language),
                    transaction.type,
                  ),
                  _buildDetailRow(
                    AppLocalizations.translate('date', language),
                    '${transaction.date.day}-${transaction.date
                        .month}-${transaction.date.year}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}