import 'package:app/home_page.dart';
import 'package:app/login_page.dart';
import 'package:app/profile_page.dart';
import 'package:app/registration_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: 
        ColorScheme.fromSeed(seedColor: Colors.brown.shade800),
        useMaterial3: true,
      ),

      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/profile': (context) => const ProfilePage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
