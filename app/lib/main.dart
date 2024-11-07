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

  final sessionBox = await Hive.openBox('sessionBox');
  final String? loggedInUser = sessionBox.get('loggedInUser') as String?;

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserState(),
      child: MainApp(
        initialRoute: loggedInUser != null ? '/home' : '/login',
        // initialRoute: '/login',
        loggedInUser: loggedInUser,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final String initialRoute;
  final String? loggedInUser;

  const MainApp({required this.initialRoute, super.key, this.loggedInUser});

  @override
  Widget build(BuildContext context) {

    if (loggedInUser != null) {
      Provider.of<UserState>(context, listen: false).setEmail(loggedInUser!);
    }

    return MaterialApp(
      title: 'Flutter Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: 
        ColorScheme.fromSeed(seedColor: Colors.brown.shade800),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/profile': (context) => const ProfilePage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
