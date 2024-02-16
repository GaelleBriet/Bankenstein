import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';

abstract class AccountDataSource {
  static const baseUrl = 'http://192.168.1.32:8000';

  static Future<List<Account>> getAccounts(String accessToken) async {
    print('getAccounts called');

    final response = await http.get(
      Uri.parse('$baseUrl/api/me/accounts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Account> accounts =
          responseBody.map((e) => Account.fromJson(e)).toList();
      return accounts;
    } else {
      throw Exception('Failed to load accounts with status code: ${response.statusCode} and body: ${response.body}');
    }
  }
}
