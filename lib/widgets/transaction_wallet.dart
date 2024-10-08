import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:repouch/controllers/wallet_controller.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final RxDouble amount;
  final Color color;

  TransactionCard({
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showClearConfirmationDialog(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF262429),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Text(
                'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(amount.value)}',
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 29, 37, 41),
          title: const Text(
            'Clear Data',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to clear this data?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.find<WalletController>().clearMonthlyTotals();
                Get.back();
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }
}
