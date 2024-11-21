import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService {
  Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.last != ConnectivityResult.none;
  }

  Stream<List<ConnectivityResult>> listenForNetworkChanges() {
    final connectivity = Connectivity();
    return connectivity.onConnectivityChanged;
  }

  void showNoConnectionDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('You have lost the internet connection. ' +
           'Please reconnect to continue using the app.',),
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
}
