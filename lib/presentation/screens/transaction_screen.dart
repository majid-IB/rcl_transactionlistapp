
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transactionBloc/transaction_bloc.dart';
import '../bloc/transactionBloc/transaction_event.dart';
import '../bloc/transactionBloc/transaction_state.dart';
import '../localization/app_localization.dart';
import '../widgets/transaction_list.dart';
import '../widgets/app_error.dart';
import '../widgets/loading_indicator.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<TransactionBloc>().add(InitializeAppSettings());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TransactionBloc>().add(LoadMoreTransactions());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            String language = 'en';
            if (state is TransactionLoaded) {
              language = state.language;
            }
            return Text(AppLocalizations.translate('title', language));
          },
        ),
        actions: [
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoaded) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Switch(
                    //   value: state.isOffline,
                    //   onChanged: (value) {
                    //     context.read<TransactionBloc>().add(ToggleOfflineMode());
                    //   },
                    // ),
                    GestureDetector(
                      onTap : (){
                        context.read<TransactionBloc>().add(ToggleOfflineMode());},
                      child: Text(AppLocalizations.translate(
                        state.isOffline ? 'offline' : 'online',
                        state.language,
                      )),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Text(state.language.toUpperCase()),
                      onPressed: () {
                        final newLang = state.language == 'en' ? 'ur' : 'en';
                        context.read<TransactionBloc>().add(ChangeLanguage(newLang));
                      },
                    ),
                    IconButton(
                      icon: Icon(state.isDarkTheme ? Icons.dark_mode : Icons.light_mode),
                      onPressed: () {
                        context.read<TransactionBloc>().add(ToggleTheme());
                      },
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return LoadingIndicator();
          }

          if (state is TransactionError) {
            return AppError(message: state.message);
          }

          if (state is TransactionLoaded) {
            if (state.transactions.isEmpty) {
              return Center(
                child: Text(AppLocalizations.translate('no_data', state.language)),
              );
            }

            return TransactionList(
              scrollController: _scrollController,
              state: state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}