import 'package:app/login/login_service.dart';
import 'package:app/network.dart';
import 'package:app/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  String? _errorMessage;

  Future<void> _login() async {
  final email = _emailController.text;
  final password = _passwordController.text;
  final NetworkService _networkService = NetworkService();

  // Отримуємо повідомлення про помилку, якщо є
  if (!await _networkService.isConnected()) {
    // No internet connection
    _networkService.showNoConnectionDialog(context);
    return;
  }
  final String? error = await _loginService.login(email, password, context);

  if (error != null) {
    setState(() {
      _errorMessage = error;
    });

    // Show error notification
    await _showDialog('Error', error);
  } else {
    // Show success notification
    await _showDialog('Success', 'Login successful!');

    Provider.of<UserState>(context, listen: false).setEmail(email);
    Navigator.pushNamed(context, '/home');
  }
}

Future<void> _showDialog(String title, String message) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_cafe, size: 100, color: Colors.brown),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextButton(
                child: const Text('Login'),
                onPressed: _login,
              ),
              const SizedBox(height: 16),
              TextButton(
                child: const Text('Register'),
                onPressed: () => Navigator.pushNamed(context, '/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
