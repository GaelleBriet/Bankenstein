class Transaction {
  final int id;
  final int fromAccountId;
  final int toAccountId;
  final int amount;
  final String date;
  final String name;

  Transaction({
    required this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.date,
    required this.name,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      fromAccountId: json['from_account_id'],
      toAccountId: json['to_account_id'],
      amount: json['amount'],
      date: json['date'],
      name: json['name'],
    );
  }
}
