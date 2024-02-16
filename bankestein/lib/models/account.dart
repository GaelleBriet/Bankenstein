import 'package:bankestein/models/transaction.dart';

class Account {
  final int id;
  final int userId;
  final String name;
  final int balance;
  final String iban;
  List<Transaction>? transactions;

  Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.iban,
    this.transactions,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      balance: json['balance'],
      iban: json['iban'],
      transactions: json['transactions'] != null
          ? (json['transactions'] as List)
              .map((i) => Transaction.fromJson(i))
              .toList()
          : null,
    );
  }
}
