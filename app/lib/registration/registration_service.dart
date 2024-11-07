import 'dart:async';
import 'package:hive/hive.dart';

class RegistrationService {
  Future<String?> register(String email, String password, String confirmPassword) async {

    if (!_isEmailValid(email)) {
      return 'Invalid email format';
    }

    if (!_isPasswordValid(password, confirmPassword)) {
      return 'Passwords do not match or are empty';
    }

    final box = await Hive.openBox('usersBox');

    // if (box.containsKey(email)) {
    //   return 'Email already exists';
    // }

    final Map<String, Object?> userInfo = {
      'password': password,
      'info': {
        'phone': null,
        'address': null,
        'bio': null,
      },
      'teas': null,
    };

    await box.put(email, userInfo);

    return null;
  }

  bool _isEmailValid(String email) {
    return email.contains('@');
  }

  bool _isPasswordValid(String password, String confirmPassword) {
    return password == confirmPassword && password.isNotEmpty;
  }
}
