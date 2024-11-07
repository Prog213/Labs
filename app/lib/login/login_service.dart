import 'package:app/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class LoginService {
  Future<String?> login(String email, String password) async {

    final box = await Hive.openBox('usersBox');

    if (!box.containsKey(email)) {
      return 'No registered user found with this email. Please register first.';
    }

    final userInfo = box.get(email);

    if (userInfo == null) {
      return 'Error retrieving user data.';
    }

    final storedPassword = userInfo['password'];

    if (storedPassword == null || storedPassword != password) {
      return 'Incorrect password.';
    }

    final sessionBox = await Hive.openBox('sessionBox');
    await sessionBox.put('loggedInUser', email);

    return null;
  }

  Future<void> logout(String email, BuildContext context) async {
    // Clear user data from Hive
    final box = await Hive.openBox('sessionBox');
    await box.delete('loggedInUser');

    // Optionally, clear the email from UserState
    Provider.of<UserState>(context, listen: false).clearUserData();

    // Navigate to the login screen
  }
}
