import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/services.dart';
import '../../../domain/entites/transactions.dart';
import '../../../domain/usecases/get_transactions.dart';
import '../../../domain/usecases/get_local_transactions.dart';
import '../../../domain/usecases/save_transactions_locally.dart';
import '../../../core/services/preferences_service.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;
  final GetLocalTransactions getLocalTransactions;
  final SaveTransactionsLocally saveTransactionsLocally;
  final PreferencesService prefsService;
  final ConnectivityService connectivityService;
  static const int _limit = 10;

  TransactionBloc({
    required this.getTransactions,
    required this.getLocalTransactions,
    required this.saveTransactionsLocally,
    required this.prefsService,
    required this.connectivityService,
  }) : super(TransactionInitial()) {
    on<InitializeAppSettings>(_onInitSettings);
    on<LoadMoreTransactions>(_onLoadMoreTransactions);
    on<ToggleOfflineMode>(_onToggleOfflineMode);
    on<ChangeLanguage>(_onChangeLanguage);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onInitSettings(InitializeAppSettings event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    bool isOffline = await prefsService.getOffline();
    final isDarkTheme = await prefsService.getTheme();
    final language = await prefsService.getLanguage();
    final online = await connectivityService.isOnline();
    if (!online) {
      isOffline = true;
    }
    try {
      final transactions = isOffline
          ? await getLocalTransactions()
          : await getTransactions(page: 1, limit: _limit);

      emit(TransactionLoaded(
        transactions: transactions,
        isOffline: isOffline,
        language: language,
        isDarkTheme: isDarkTheme,
        currentPage: 1,
        hasReachedMax: transactions.length < _limit,
      ));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onLoadMoreTransactions(LoadMoreTransactions event, Emitter<TransactionState> emit) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;

      if (currentState.isLoadingMore || currentState.hasReachedMax || currentState.isOffline) {
        return;
      }

      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final nextPage = currentState.currentPage + 1;
        final newTransactions = await getTransactions(page: nextPage, limit: _limit);
        final allTransactions = [...currentState.transactions, ...newTransactions];

        emit(currentState.copyWith(
          transactions: allTransactions,
          isLoadingMore: false,
          hasReachedMax: newTransactions.length < _limit,
          currentPage: nextPage,
        ));
      } catch (_) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }

  Future<void> _onToggleOfflineMode(ToggleOfflineMode event, Emitter<TransactionState> emit) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      final newOfflineState = !currentState.isOffline;
      await prefsService.saveOffline(newOfflineState);

      emit(TransactionLoading());

      try {
        final transactions = newOfflineState
            ? await getLocalTransactions()
            : await getTransactions(page: 1, limit: _limit);

        emit(currentState.copyWith(
          transactions: transactions,
          isOffline: newOfflineState,
          currentPage: 1,
          hasReachedMax: newOfflineState || transactions.length < _limit,
        ));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    }
  }

  void _onChangeLanguage(ChangeLanguage event, Emitter<TransactionState> emit) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      await prefsService.saveLanguage(event.language);
      emit(currentState.copyWith(language: event.language));
    }
  }

  void _onToggleTheme(ToggleTheme event, Emitter<TransactionState> emit) async {
    if (state is TransactionLoaded) {
      final currentState = state as TransactionLoaded;
      final newTheme = !currentState.isDarkTheme;
      await prefsService.saveTheme(newTheme);
      emit(currentState.copyWith(isDarkTheme: newTheme));
    }
  }
}
