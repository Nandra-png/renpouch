import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/home_screen.dart';

import 'package:repouch/login_page.dart';
import 'package:repouch/splash_screen.dart'; // Untuk timer

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash', // Set initial route ke splash
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()), // Splash Screen
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
