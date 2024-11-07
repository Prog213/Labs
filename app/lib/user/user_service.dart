import 'package:hive/hive.dart';

class UserService {
  // Update user information (phone, address, bio)
  Future<void> updateUserInfo(
      String email, String phone, String address, String bio,) async {
    final box = await Hive.openBox('usersBox');
    final userData = box.get(email);

    if (userData != null) {
        userData['info']['phone'] = phone;
        userData['info']['address'] = address;
        userData['info']['bio'] = bio;
      }

      // Save updated data back to Hive
      await box.put(email, userData);
    }

  // Retrieve user data for a specific email
  Future<dynamic> getUserData(String email) async {
    final box = await Hive.openBox('usersBox');
    final userData = box.get(email);

    return userData['info'];
  }

  Future<dynamic> getUserTeas(String email) async {
    final box = await Hive.openBox('usersBox');
    final userData = box.get(email);

    if (userData['teas'] != null){
      return userData['teas'];
    }
    return List<dynamic>.empty();
  }

  // Add a tea to the user's tea list
  Future<void> addTea(String email, String teaName, double price) async {
    final box = await Hive.openBox('usersBox');
    final userData = box.get(email);

      if (userData['teas'] != null){
        (userData['teas'] as List).add({
          'name': teaName,
          'price': price,
        });
        await box.put(email, userData);
      }

      else{
        userData['teas'] = [{
          'name': teaName,
          'price': price,
        }];
        await box.put(email, userData);
      }
    }
  

  // Редагувати чай в списку чаїв користувача
  Future<void> editTea(String email, int teaIndex, String newName, double newPrice) 
  
  async {
    final box = await Hive.openBox('usersBox');
    final userData = box.get(email);

    // Оновлюємо відповідний чай
    (userData['teas'] as List)[teaIndex] = {
      'name': newName,
      'price': newPrice,
    };

    // Зберегти оновлені дані користувача в Hive
    await box.put(email, userData);
  }

  // Видалити чай з списку чаїв користувача
  Future<void> deleteTea(String email, int teaIndex) async {
    final box = await Hive.openBox('usersBox');
    final userData = box.get(email);

    // Видаляємо чай за індексом
    (userData['teas'] as List).removeAt(teaIndex);

    // Зберегти оновлені дані користувача в Hive
    await box.put(email, userData);
  }
}
