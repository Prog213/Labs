import 'dart:async';

import 'package:app/login/login_service.dart';
import 'package:app/network.dart';
import 'package:app/profile/profile_info_row.dart';
import 'package:app/user/user_service.dart';
import 'package:app/user/user_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String _phone = '';
  String _address = '';
  String _bio = '';
  final NetworkService _networkService = NetworkService();
  late StreamSubscription<List<ConnectivityResult>> _networkSubscription;

  @override
  void initState() {
    super.initState();
    _loadData();

    _networkSubscription = _networkService.listenForNetworkChanges().listen((result) {
      if (result.last == ConnectivityResult.none) {
        _networkService.showNoConnectionDialog(context);
      }
    });
  }

  @override
  void dispose() {
    _networkSubscription.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    email = Provider.of<UserState>(context, listen: false).email;
    final userData = await UserService().getUserData(email);

    if (userData['phone'] != null) {
      setState(() {
        _phone = userData['phone'] as String;
      });
    }

    if (userData['address'] != null) {
      setState(() {
        _address = userData['address'] as String;
      });
    }

    if (userData['bio'] != null) {
      setState(() {
        _bio = userData['bio'] as String;
        });
    }
  }

  // Method for editing fields
  void _editField(String field, String newValue) {
    setState(() {
      switch (field) {
        case 'phone':
          _phone = newValue;
          break;
        case 'address':
          _address = newValue;
          break;
        case 'bio':
          _bio = newValue;
          break;
      }
    });

    // Save updated data to Hive
    _saveData();
  }

  Future<void> _saveData() async {
    await UserService().updateUserInfo(email, _phone, _address, _bio);
  }

  // Show confirmation dialog for logout
  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login'); // Close the dialog
                LoginService().logout(email, context); // Perform logout
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
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _showLogoutDialog, // Show logout confirmation
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('lib/assets/user.png'),
            ),
            const SizedBox(height: 20),

            const Text(
              'Yaroslav Lepko',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Display email without allowing edits
            Row(
              children: [
                const Text(
                  'Email: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Phone Field
            ProfileInfoRow(
              title: 'Phone:',
              content: _phone,
              onEdit: (newValue) => _editField('phone', newValue),
            ),
            const SizedBox(height: 10),

            // Address Field
            ProfileInfoRow(
              title: 'Address:',
              content: _address,
              onEdit: (newValue) => _editField('address', newValue),
            ),
            const SizedBox(height: 10),

            // Bio Field
            ProfileInfoRow(
              title: 'Bio:',
              content: _bio,
              onEdit: (newValue) => _editField('bio', newValue),
            ),
          ],
        ),
      ),
    );
  }
}
