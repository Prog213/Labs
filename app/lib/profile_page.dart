import 'package:app/profile_info_row.dart'; // Імпортуємо новий файл
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // User Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('build/flutter_assets/images/user.png'),
            ),
            SizedBox(height: 20),
            
            // User Name
            Text(
              'Yaroslav Lepko',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Email
            Text(
              'example@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),

            // Other information or fields
            Divider(),
            SizedBox(height: 10),

            // Information Fields
            ProfileInfoRow(title: 'Phone:', content: '+123456789'),
            SizedBox(height: 10),
            ProfileInfoRow(title: 'Address:', 
            content: '123 Lukasha, Lviv', ),
            SizedBox(height: 10),
            ProfileInfoRow(title: 'Bio:', 
            content: 'Love Flutter', ),
          ],
        ),
      ),
    );
  }
}
