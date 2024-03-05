import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/account.dart';
import '../data/account_data_source.dart';
import 'authentication_cubit.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AuthenticationCubit authCubit;
  StreamSubscription? _authSubscription;
  String? accessToken;

  AccountCubit(this.authCubit) : super(AccountInitial()) {
    // _authSubscription = authCubit.stream.listen((state) {
    //   if (state is AuthenticationAuthenticated) {
    //     getAccounts(state.accessToken);
    //   }
    // });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  Future<void> getAccounts(String accessToken) async {
    this.accessToken = accessToken;
    try {
      emit(AccountLoading());
      final accounts = await AccountDataSource.getAccounts(accessToken);
      print('Accounts : $accounts');
      emit(AccountsLoaded(accounts));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> getAccount(String accessToken, int id) async {
    this.accessToken = accessToken;
    try {
      emit(AccountLoading());
      final account = await AccountDataSource.getAccount(accessToken, id);
      emit(AccountLoaded(account));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<Account> getAccountIban(String accessToken, int id) async {
    this.accessToken = accessToken;
    try {
      emit(AccountLoading());
      var account = await AccountDataSource.getAccount(accessToken, id);
      emit(AccountLoaded(account));
      return account;
    } catch (e) {
      emit(AccountError(e.toString()));
      throw Exception('Failed to get account IBAN');
    }
  }

  void reset() {
    emit(AccountReset());
  }

  Future<void> refresh() async {
    String? accessToken;
    if (authCubit.state is AuthenticationAuthenticated) {
      accessToken = (authCubit.state as AuthenticationAuthenticated).accessToken;
    }
    getAccounts(accessToken!);
  }

}
