import 'package:hive/hive.dart';

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

    return null;
  }
}
