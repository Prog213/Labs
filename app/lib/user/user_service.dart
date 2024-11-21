import 'dart:convert';

import 'package:app/user/user_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class UserService {
  final apiBaseUrl = 'http://localhost:5156/api';

  Future<void> updateUserInfo(String address, String bio) async {
    final userInfoDTO = {
      'address': address,
      'bio': bio,
    };

    final response = await http.post(
      Uri.parse('$apiBaseUrl/User/update-info'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userInfoDTO),
    );

    if (response.statusCode == 200) {
      final user = await getUserFromHive();
      user.address = address;
      user.bio = bio;
      await saveUserToHive(user);
    } else {
      throw Exception('Failed to update user info: ${response.body}');
    }
  }

  Future<User> getUserData() async {
    return await getUserFromHive();
  }

  Future<List<Tea>> getUserTeas() async {
    User user = await getUserFromHive();

    if (user.teas != List<dynamic>.empty()) {
      return user.teas;
    }
    return List<Tea>.empty();
  }

  Future<User> getUserFromHive() async {
    final box = await Hive.openBox('sessionBox');
    final userData = box.get('loggedInUser');

    final data = jsonDecode(userData as String);
    final user = User.fromJson(data as Map<String, dynamic>);
    return user;
  }

  Future<void> saveUserToHive(User user) async {
    final sessionBox = await Hive.openBox('sessionBox');
    await sessionBox.put('loggedInUser', json.encode(user));
  }

  Future<String> getToken() async {
    final user = await getUserFromHive();
    return user.token;
  }

  Future<void> addTea(String teaName, double price) async {
    final teaData = {
      'name': teaName,
      'price': price,
    };

    final response = await http.post(
      Uri.parse('$apiBaseUrl/Tea'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await getToken()}',
      },
      body: jsonEncode(teaData),
    );

    if (response.statusCode == 200) {
      final user = await getUserFromHive();
      user.teas.add(Tea(name: teaName, price: price));
      await saveUserToHive(user);
    } else {
      throw Exception('Failed to add tea: ${response.body}');
    }
  }

  Future<void> updateTea(
      String teaName, String newTeaName, double newPrice) async {
    final response = await http.put(
      Uri.parse('$apiBaseUrl/Tea/$teaName'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': newTeaName,
        'price': newPrice,
      }),
    );

    if (response.statusCode == 200) {
      final user = await getUserFromHive();

      final teaIndex = user.teas.indexWhere((tea) => tea.name == teaName);
      if (teaIndex != -1) {
        user.teas[teaIndex] = Tea(
          name: newTeaName,
          price: newPrice,
        );
      }

      await saveUserToHive(user);
    } else {
      throw Exception('Failed to update tea: ${response.body}');
    }
  }

  Future<void> deleteTea(String teaName) async {
    final response = await http.delete(
      Uri.parse('$apiBaseUrl/Tea/$teaName'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}',
      },
    );

    if (response.statusCode == 200) {
      final user = await getUserFromHive();
      user.teas = user.teas.where((tea) => tea.name != teaName).toList();

      await saveUserToHive(user);
    } else {
      throw Exception('Failed to delete tea: ${response.body}');
    }
  }
}
