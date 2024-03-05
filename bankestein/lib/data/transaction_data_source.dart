import 'dart:convert';
import 'package:bankestein/data/account_data_source.dart';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';
import '../services/transaction_service.dart';

abstract class TransactionDataSource {
  static const baseUrl = 'http://192.168.1.32:8000';

  static Future<List<Transaction>> getAccountTransactions(String accessToken,
      int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/me/accounts/$id/transactions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Transaction> transactions =
      responseBody.map((e) => Transaction.fromJson(e)).toList();
      transactions = TransactionService.sortTransactions(transactions, id);
      return transactions;
    } else {
      throw Exception(
          'Failed to load transactions with status code: ${response
              .statusCode} and body: ${response.body}');
    }
  }

  static Future<void> transfer(String accessToken, int fromAccountId,
      double amount, int toAccountId, String name) async {
    print('transfer API');
    final response = await http.post(
      Uri.parse('$baseUrl/api/me/transactions/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, dynamic>{
        'from_account_id': fromAccountId,
        'to_account_id': toAccountId,
        'amount': amount,
        'name': name,
        'date': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to transfer with status code: ${response
              .statusCode} and body: ${response.body}');
    }
  }

  static Future<List<Transaction>> getLastThreeTransactions(String accessToken,
      int userId) async {
    // récupérer les comptes de l'utilisateur
    final accounts = await AccountDataSource.getAccounts(accessToken);
    List<Transaction> allTransactions = [];

    for (var account in accounts) {
      final response = await http.get(
        Uri.parse('$baseUrl/api/me/accounts/${account.id}/transactions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);
        List<Transaction> transactions =
        responseBody.map((e) => Transaction.fromJson(e)).toList();
        allTransactions.addAll(transactions);
      } else {
        throw Exception(
            'Failed to load transactions with status code: ${response
                .statusCode} and body: ${response.body}');
      }
    }
    allTransactions.sort((a, b) => b.date.compareTo(a.date));
    List<Transaction> lastThreeTransactions = allTransactions.take(3).toList();

    return lastThreeTransactions;
  }
}