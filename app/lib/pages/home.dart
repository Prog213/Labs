// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  String _message = '';
  final TextEditingController _controller = TextEditingController();

  void _updateCounter() {
    final String input = _controller.text.trim();

    if (input.toLowerCase() == 'avada kedavra') {
      setState(() {
        _counter = 0;
        _message = 'Magic spell detected! Counter reset to 0!';
      });
    } else {
      try {
        final value = int.parse(input);
        setState(() {
          _counter += value;
          _message = 'Counter incremented by $value!';
        });
      } catch (e) {
        setState(() {
          _message = "Invalid input. Please enter a number or 'Avada Kedavra'.";
        });
      }
    }
    _controller.clear();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 1'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            // Spacer to push the counter to the center
            const Spacer(),
            // Centered Counter
            Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Input and buttons at the bottom
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a number or a magic spell',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _updateCounter,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 40), // Margin from the bottom
          ],
        ),
      ),
    );
  }
}
