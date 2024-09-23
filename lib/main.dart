import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/amountparse_controller.dart';
import 'package:repouch/controllers/wallet_controller.dart';
import 'package:repouch/screens/home_screen.dart';
import 'package:repouch/screens/login_page.dart';
import 'package:repouch/screens/splash_screen.dart'; // Untuk timer

void main() {
    
  Get.put(WalletController()); 
  Get.put(AmountParserController()); // AmountParserController

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
