import 'package:bankestein/models/recipient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class RecipientService {
  // static const baseUrl = 'http://uriostegui-sam-server.eddi.cloud:8000';
  static const baseUrl = 'http://192.168.1.32:8000';

  static Future<List<Recipient>> getRecipients(String accessToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/me/recipients'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Recipient> recipients =
          responseBody.map((e) => Recipient.fromJson(e)).toList();
      return recipients;
    } else {
      throw Exception(
          'Failed to load recipients with status code: ${response.statusCode} and body: ${response.body}');
    }
  }

  static Future<void> addRecipient(
      String accessToken, String name, String iban) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/me/recipients/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{'name': name, 'iban': iban}),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to add recipient: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error while adding recipient: $error');
    }
  }

  static Future<void> updateRecipient(
      String accessToken, String name, String iban) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/me/recipients/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{'name': name, 'iban': iban}),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to update recipient: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error while updating recipient: $error');
    }
  }

  static Future<void> deleteRecipient(
      String accessToken, int recipientId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/me/recipients/$recipientId/delete'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print("all good");
      } else {
        // Handle error if deletion failed
        print('Failed to delete recipient: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the deletion process
      print('Error while deleting recipient: $error');
    }
  }
}
