import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/WD_screen.dart';
import 'package:repouch/main_wallet.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final RxInt currentIndex = 0.obs;

  final List<Widget> screens = [
    WalletScreen(),
    WithdrawDepositScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) => currentIndex.value = index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.transfer_within_a_station), label: 'Withdraw/Deposit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      )),
    );
  }
}
