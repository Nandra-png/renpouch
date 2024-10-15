import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:repouch/controllers/wallet_controller.dart';

class BalanceDisplay extends StatelessWidget {
  final WalletController walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBalanceDetail(context),
      child: Obx(() {
        double balance = walletController.balance.value;
        return Center(
          child: Text(
            _formatBalance(balance),
            style: TextStyle(
              fontSize: 34,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }

  String _formatBalance(double amount) {
    if (amount >= 1e9) {
      return 'Rp. ${((amount / 1e9).toStringAsFixed(2))} Billion';
    } else if (amount >= 1e6) {
      return 'Rp. ${((amount / 1e6).toStringAsFixed(2))} Million';
    } else {
      return 'Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(amount)}';
    }
  }

  void _showBalanceDetail(BuildContext context) {
    double balance = walletController.balance.value;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 29, 37, 41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Your Balance',
            style: TextStyle(
              color: Colors.white, // Title color
            ),
          ),
          content: Container(
            width: double.maxFinite, // Set the width to the max possible
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(balance)}',
                  style: TextStyle(
                    color: Colors.greenAccent, // Change text color
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20), // Add some space
                Text(
                  'Keep track of your expenses and savings!',
                  style: TextStyle(
                    color: Colors.white54, // Change description color
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: const Color.fromARGB(
                      255, 243, 33, 33), // Button text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
