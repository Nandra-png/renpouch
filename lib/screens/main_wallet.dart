import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:repouch/controllers/amountparse_controller.dart';
import 'package:repouch/controllers/wallet_controller.dart';
import 'package:repouch/screens/popup_wallet_screen.dart';


class WalletScreen extends StatelessWidget {
  final WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    // Inisialisasi AmountParserController di sini jika hanya digunakan di layar ini
    Get.put(AmountParserController());

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showWithdrawDepositPopup(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showWithdrawDepositPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return WithdrawDepositPopup();
      },
    );
  }
}
