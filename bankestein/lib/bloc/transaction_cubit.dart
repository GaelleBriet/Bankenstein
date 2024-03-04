import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/transaction.dart';
import '../data/transaction_data_source.dart';
import 'authentication_cubit.dart';
part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final AuthenticationCubit authCubit;

  TransactionCubit(this.authCubit) : super(TransactionInitial());

  Future<void> getAccountTransactions(String accessToken, int id) async {
    try {
      emit(TransactionLoading());
      final transactions =
          await TransactionDataSource.getAccountTransactions(accessToken, id);
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
