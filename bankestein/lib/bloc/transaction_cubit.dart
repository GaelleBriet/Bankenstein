import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bankestein/data/account_data_source.dart';
import '../data/transaction_data_source.dart';

import 'authentication_cubit.dart';

import '../models/account.dart';
import '../models/transaction.dart';

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

  Future<void> transfer(
      int fromAccountId, double amount, int toAccountId, String name) async {
    try {
      final accessToken =
          (authCubit.state as AuthenticationAuthenticated).accessToken;
      var amountInCents = (amount * 100);
      await TransactionDataSource.transfer(
          accessToken, fromAccountId, amountInCents, toAccountId, name);
      emit(TransactionTransferSuccess());
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
