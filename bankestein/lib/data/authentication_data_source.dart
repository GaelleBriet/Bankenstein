import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthenticationDataSource {
  // static const baseUrl = 'http://localhost:3000';
  // static const baseUrl = 'http://10.0.2.2:8000';
  static const baseUrl = 'http://192.168.1.32:8000';

  static final StreamController<String?> _authController =
      StreamController<String?>.broadcast();

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String accessToken = responseBody['access_token'];
      _authController.add(accessToken);
      return accessToken;
      // return true;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<void> logout() async {
    // Add your logout logic here
    _authController.add(null);
  }

  static Future<String> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String userName = responseBody['name'];
      return userName;
    } else {
      throw Exception('Failed to load user info');
    }
  }

  static Stream<String?> authChanges() {
    return _authController.stream;
  }
}
