import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrationService {
  final String baseUrl = 'http://localhost:5156/api/account';
  Future<String?> register(String email, String password, String confirmPassword) async {

    if (!_isEmailValid(email)) {
      return 'Invalid email format';
    }

    if (!_isPasswordValid(password, confirmPassword)) {
      return 'Passwords do not match or are empty';
    }

    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return null; 
    } else {
      return 'Registration failed';
    }

  }

  bool _isEmailValid(String email) {
    return email.contains('@');
  }

  bool _isPasswordValid(String password, String confirmPassword) {
    return password == confirmPassword && password.isNotEmpty;
  }
}
