import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:repouch/screens/history_screen.dart';
import 'package:repouch/screens/main_wallet.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final RxInt currentIndex = 0.obs;

  final List<Widget> screens = [
    WalletScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  final List<String> labels = ["Wallet", "History", "Profile"];
  final List<IconData> icons = [
    Icons.wallet,
    Icons.history,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: currentIndex.value,
            children: screens,
          )),
      bottomNavigationBar: MotionTabBar(
        labels: labels,
        icons: icons,
        initialSelectedTab: labels[0],
        onTabItemSelected: (index) {
          currentIndex.value = index;
        },
        tabIconColor: Colors.grey[400], 
        tabSelectedColor: Colors.greenAccent,
        tabBarColor: Colors.blueGrey[800],
        textStyle: TextStyle(color: Colors.white), 
      ),
    );
  }
}
