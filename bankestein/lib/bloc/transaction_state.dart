part of 'transaction_cubit.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;
  TransactionError(this.message);
}

class TransactionTransferSuccess extends TransactionState {}
// class TransactionTransferSuccess extends TransactionState {
//   final double amountToTransfer;
//   final String accountName;
//   final Account destinationAccount;
//
//   TransactionTransferSuccess({
//     required this.amountToTransfer,
//     required this.accountName,
//     required this.destinationAccount,
//   });
// }
