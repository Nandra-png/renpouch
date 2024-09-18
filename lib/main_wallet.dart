import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl untuk format angka
import 'package:repouch/wallet_controller.dart';

class WalletScreen extends StatelessWidget {
  final WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Wallet')),
      body: Center(
        child: Obx(() {
          String formattedBalance = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp',
            decimalDigits: 0,
          ).format(walletController.balance.value);

          return Text(
            'Balance: $formattedBalance',
            style: TextStyle(fontSize: 24),
          );
        }),
      ),
    );
  }
}
