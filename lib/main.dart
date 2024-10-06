import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/amountparse_controller.dart';
import 'package:repouch/controllers/history_controller.dart';
import 'package:repouch/controllers/wallet_controller.dart';
import 'package:repouch/screens/bottom_nav_screen.dart';
import 'package:repouch/screens/login_page.dart';

void main() {
  Get.put(WalletController());
  Get.put(AmountParserController());
  Get.put(HistoryController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'renpouch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => BottomNav()),
      ],
    );
  }
}
