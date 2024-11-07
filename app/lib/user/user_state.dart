import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String _email = '';

  String get email => _email;

  void setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }
}
