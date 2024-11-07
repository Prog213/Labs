import 'package:app/tea.dart';
import 'package:app/user/user_service.dart';
import 'package:app/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic teas = [];
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadTeas();
  }

  // Завантажуємо чаї користувача
  Future<void> _loadTeas() async {
    email = Provider.of<UserState>(context, listen: false).email;
    final loadedteas = await UserService().getUserTeas(email);
    setState(() {
      teas = loadedteas;
  });
  }

  Future<void> _addTea(String name, double price) async {
    final userService = UserService();
    await userService.addTea(email, name, price);
    _loadTeas();
  }

  Future<void> _updateTea(int index, String newName, double newPrice) async {
    final userService = UserService();
    await userService.editTea(email, index, newName, newPrice);
    _loadTeas();
  }

  Future<void> _deleteTea(int index) async {
    final userService = UserService();
    await userService.deleteTea(email, index);
    _loadTeas();
  }

  void _showAddTeaDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Tea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Tea Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String name = nameController.text;
                final double price = double.tryParse(priceController.text) ?? 0.0;

                if (name.isNotEmpty && price > 0) {
                  _addTea(name, price);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/user.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Teas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: (teas as List).length,
                itemBuilder: (context, index) {
                  final tea = teas[index];
                  return TeaItem(
                    name: tea['name'] as String,
                    price: tea['price'] as double,
                    onEdit: (newName, newPrice) =>
                        _updateTea(index, newName, newPrice),
                    onDelete: () => _deleteTea(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTeaDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
