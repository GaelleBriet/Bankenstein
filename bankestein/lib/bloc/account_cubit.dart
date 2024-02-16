import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/account.dart';
import '../data/account_data_source.dart';
import 'authentication_cubit.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AuthenticationCubit authCubit;
  StreamSubscription? _authSubscription;

  AccountCubit(this.authCubit) : super(AccountInitial()) {
    _authSubscription = authCubit.stream.listen((state) {
      if (state is AuthenticationAuthenticated) {
        getAccounts(state.accessToken);
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  Future<void> getAccounts(String accessToken) async {
    try {
      emit(AccountLoading());
      print('Access Token: $accessToken');
      final accounts = await AccountDataSource.getAccounts(accessToken);
      print('accounts: $accounts');
      emit(AccountLoaded(accounts));
    } catch (e) {
      print('error: $e');
      emit(AccountError(e.toString()));
    }
  }

  Future<void> getAccount(String accessToken, int id) async {
    try {
      emit(AccountLoading());
      final account = await AccountDataSource.getAccount(accessToken, id);
      emit(AccountLoaded([account]));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }
}
