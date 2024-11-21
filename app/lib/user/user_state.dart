import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String _email = '';
  String _token = '';

  String get email => _email;
  String get token => _token;

  void setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  void clearUserData(){
    _email = '';
    _token = '';
  }
}
