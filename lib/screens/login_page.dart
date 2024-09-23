import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/wallet.png'), // Add logo in assets 
            SizedBox(height: 20),
            Text(
              'REPOUCH',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              'Your Financial Manager',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(HomeScreen());
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
