
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rcl_transactionlistapp/domain/entites/transactions.dart';
import 'package:rcl_transactionlistapp/presentation/bloc/transactionBloc/transaction_state.dart';
import 'package:rcl_transactionlistapp/presentation/localization/app_localization.dart';
import 'package:rcl_transactionlistapp/presentation/widgets/transaction_list.dart';



void main() {
  late ScrollController scrollController;
  final sampleDate = DateTime(2023, 6, 15);
  late TransactionLoaded testState;


  setUp(() {
    scrollController = ScrollController();

    testState = TransactionLoaded(
      transactions: [
        Transaction(
          id: '1',
          date: sampleDate,
          amount: 100.50,
          type: 'invoice',
          merchant: 'Test Merchant',
        ),
        Transaction(
          id: '2',
          date: sampleDate,
          amount: 75.25,
          type: 'payment',
          merchant: 'Another Merchant',
        ),
      ],
      isOffline: false,
      language: 'en',
      isDarkTheme: false,
    );
  });

  tearDown(() {
    scrollController.dispose();
  });

  testWidgets('renders transaction cards with correct data', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TransactionList(
            scrollController: scrollController,
            state: testState,
          ),
        ),
      ),
    );


    expect(find.text('Test Merchant'), findsOneWidget);
    expect(find.text('Another Merchant'), findsOneWidget);

    // Verify amounts
    expect(find.text('\$100.50'), findsOneWidget);
    expect(find.text('\$75.25'), findsOneWidget);


    expect(find.text('invoice'), findsOneWidget);
    expect(find.text('payment'), findsOneWidget);

    final datePrefix = AppLocalizations.translate('date', 'en');
    final formattedDate = '$datePrefix: ${sampleDate.day}-${sampleDate.month}-${sampleDate.year}';
    expect(find.text(formattedDate), findsNWidgets(2));


    expect(find.byType(Card), findsNWidgets(2));
    expect(find.byType(ListTile), findsNWidgets(2));
  });
}