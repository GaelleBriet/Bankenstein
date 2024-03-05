import 'package:bankestein/models/transaction.dart';

abstract class TransactionService {
  static List<Transaction> sortTransactions(
      List<Transaction> transactions, int accountId) {
    return transactions.map((transaction) {
      if (transaction.toAccountId == accountId) {
        // Si le compte est le bénéficiaire de la transaction, le montant est positif
        return Transaction(
          id: transaction.id,
          fromAccountId: transaction.fromAccountId,
          toAccountId: transaction.toAccountId,
          amount: transaction.amount,
          date: transaction.date,
          name: transaction.name,
        );
      } else {
        // Si le compte est le débiteur de la transaction, le montant est négatif
        return Transaction(
          id: transaction.id,
          fromAccountId: transaction.fromAccountId,
          toAccountId: transaction.toAccountId,
          amount: -transaction.amount,
          date: transaction.date,
          name: transaction.name,
        );
      }
    }).toList();
  }

  static List<Transaction> getLastThreeTransactions(
      List<Transaction> transactions, int accountId) {
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions.take(3).toList();
  }
}
