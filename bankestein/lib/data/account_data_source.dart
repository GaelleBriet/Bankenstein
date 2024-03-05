import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';
import '../models/transaction.dart';
import '../services/transaction_service.dart';

abstract class AccountDataSource {
  static const baseUrl = 'http://192.168.1.32:8000';

  static Future<List<Account>> getAccounts(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/me/accounts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Account> accounts =
          responseBody.map((e) => Account.fromJson(e)).toList();
      return accounts;
    } else {
      throw Exception(
          'Failed to load accounts with status code: ${response.statusCode} and body: ${response.body}');
    }
  }

  static Future<Account> getAccount(String accessToken, int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/me/accounts/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to load account with status code: ${response.statusCode} and body: ${response.body}');
    }
  }
}
