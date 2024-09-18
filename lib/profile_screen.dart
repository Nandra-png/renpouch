import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/login_page.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.offAll(LoginScreen());
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
