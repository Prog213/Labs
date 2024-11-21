import 'dart:convert';
import 'package:app/user/user_model.dart';
import 'package:app/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginService {
  final String baseUrl = 'http://localhost:5156/api/account';

  Future<String?> login(String email, String password, BuildContext context) async {

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User.fromJson(data as Map<String, dynamic>);

      Provider.of<UserState>(context, listen: false).setToken(data['token'] as String);

      final sessionBox = await Hive.openBox('sessionBox');
      await sessionBox.put('loggedInUser', json.encode(user));

      return null; // Успішний вхід
    } else {
      return jsonDecode(response.body)['error'] as String? ?? 'Login failed';
    }
  }

  Future<void> logout(BuildContext context) async {
    // Clear user data from Hive
    final box = await Hive.openBox('sessionBox');
    await box.delete('loggedInUser');

    // Optionally, clear the email from UserState
    Provider.of<UserState>(context, listen: false).clearUserData();
  }
}
