import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: 
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 255, 42)),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
