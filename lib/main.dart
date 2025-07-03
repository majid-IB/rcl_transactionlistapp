// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rcl_transactionlistapp/presentation/bloc/transactionBloc/transaction_bloc.dart';
import 'package:rcl_transactionlistapp/presentation/bloc/transactionBloc/transaction_event.dart';
import 'package:rcl_transactionlistapp/presentation/bloc/transactionBloc/transaction_state.dart';
import 'package:rcl_transactionlistapp/presentation/bloc/transactionDetailsBloc/transaction_details_bloc.dart';
import 'package:rcl_transactionlistapp/presentation/screens/transaction_screen.dart';

import 'core/services/preferences_service.dart';
import 'core/services/services.dart';
import 'data/datasources/transaction_local.dart';
import 'data/datasources/transaction_remote.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'domain/usecases/get_transactions.dart';
import 'domain/usecases/get_local_transactions.dart';
import 'domain/usecases/save_transactions_locally.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await dotenv.load();

  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  TransactionRepositoryImpl createRepository() {
    final httpClient = http.Client();
    final remoteDataSource = TransactionRemoteDataSourceImpl(client: httpClient);
    final localDataSource = TransactionLocalDataSourceImpl();

    return TransactionRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  }
  @override
  Widget build(BuildContext context) {
    final repository = createRepository();
    final preferencesService = PreferencesService();
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => TransactionBloc(
            getTransactions: GetTransactions(repository),
            getLocalTransactions: GetLocalTransactions(repository),
            saveTransactionsLocally: SaveTransactionsLocally(repository),
            prefsService: preferencesService,
            connectivityService: ConnectivityService(),
          )..add(InitializeAppSettings()),
        ),
        BlocProvider(
          create: (context) => TransactionDetailsBloc(
            preferencesService: preferencesService, // Same shared instance
          ),
        ),
      ],
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          bool isDarkTheme = false;
          if (state is TransactionLoaded) {
            isDarkTheme = state.isDarkTheme;
          }

          return MaterialApp(
            title: 'Transaction App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: isDarkTheme ? Brightness.dark : Brightness.light,
              useMaterial3: true,
            ),
            home: TransactionScreen(),
          );
        },
      ),
    );
  }
}