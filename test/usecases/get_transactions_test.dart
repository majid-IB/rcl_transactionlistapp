import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rcl_transactionlistapp/domain/entites/transactions.dart';
import 'package:rcl_transactionlistapp/domain/usecases/get_transactions.dart';
import '../mocks/mock_repository.mocks.dart';

void main() {
  late GetTransactions usecase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    usecase = GetTransactions(mockRepository);
  });

  test('should return paginated transaction list from repository', () async {

    const page = 1;
    const limit = 10;

    final transactions = List.generate(
      10,
          (index) => Transaction(
        id: '$index',
        amount: 100.0,
        date: DateTime.now(),
        type: 'invoice',
        merchant: 'Merchant $index',
      ),
    );

    when(mockRepository.getTransactions(page: page, limit: limit))
        .thenAnswer((_) async => transactions);

    final result = await usecase(page: page, limit: limit);

    expect(result, equals(transactions));
    verify(mockRepository.getTransactions(page: page, limit: limit)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
