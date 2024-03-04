class Recipient {
  final int id;
  final String name;
  final int userId;
  final int accountId;
  final String iban;

  Recipient({
    required this.id,
    required this.name,
    required this.userId,
    required this.accountId,
    required this.iban,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      accountId: json['account_id'],
      iban: json['iban'],
    );
  }
}
