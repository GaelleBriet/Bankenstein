part of 'account_cubit.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final Account account;
  AccountLoaded(this.account);
}

class AccountsLoaded extends AccountState {
  final List<Account> accounts;
  AccountsLoaded(this.accounts);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}

class AccountReset extends AccountState {}
