import 'package:app/tea.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to Profile Page when the image is tapped
              Navigator.pushNamed(context, '/profile');
            },
            icon: const CircleAvatar(
              backgroundImage: AssetImage('build/flutter_assets/images/user.png'),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Teas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            // List of TeaItems
            TeaItem(name: 'Green Tea', price: 2.99),
            TeaItem(name: 'Black Tea', price: 3.49),
            TeaItem(name: 'Herbal Tea', price: 4.29),
            TeaItem(name: 'Chai Tea', price: 3.99),
            TeaItem(name: 'Gray Tea', price: 5.19),
          ],
        ),
      ),
    );
  }
}
