import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionEvent {}
class InitializeAppSettings extends TransactionEvent {}
class LoadMoreTransactions extends TransactionEvent {}

class ToggleOfflineMode extends TransactionEvent {}

class ChangeLanguage extends TransactionEvent {
  final String language;

  const ChangeLanguage(this.language);

  @override
  List<Object> get props => [language];
}

class ToggleTheme extends TransactionEvent {}