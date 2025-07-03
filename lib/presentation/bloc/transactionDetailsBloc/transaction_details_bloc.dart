
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/preferences_service.dart';
import 'transaction_details_event.dart';
import 'transaction_details_state.dart';

class TransactionDetailsBloc extends Bloc<TransactionDetailsEvent, TransactionDetailsState> {
  final PreferencesService preferencesService;

  TransactionDetailsBloc({
    required this.preferencesService,
  }) : super(TransactionDetailsInitial()) {
    on<LoadTransactionDetails>(_onLoadTransactionDetails);
  }

  Future<void> _onLoadTransactionDetails(
      LoadTransactionDetails event,
      Emitter<TransactionDetailsState> emit,
      ) async {
    emit(TransactionDetailsLoading());

    try {
      final language = await preferencesService.getLanguage();
      final isDarkTheme = await preferencesService.getTheme();

      emit(TransactionDetailsLoaded(
        transaction: event.transaction,
        language: language,
        isDarkTheme: isDarkTheme,
      ));
    } catch (e) {
      emit(TransactionDetailsLoaded(
        transaction: event.transaction,
        language: 'en',
        isDarkTheme: false,
      ));
    }
  }
}