class Account {
  final int id;
  final int userId;
  final String name;
  final int balance;
  final String iban;

  Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.iban,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      balance: json['balance'],
      iban: json['iban'],
    );
  }
}
