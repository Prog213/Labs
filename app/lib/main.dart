import 'package:app/home_page.dart';
import 'package:app/login/login_page.dart';
import 'package:app/profile/profile_page.dart';
import 'package:app/registration/registration_page.dart';
import 'package:app/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and set the directory
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserState(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
