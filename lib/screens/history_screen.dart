import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/history_controller.dart';
import 'package:repouch/widgets/header_history.dart';
import 'package:repouch/widgets/transaction_list.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              HistoryHeader(
                  onClearHistory: () => _showClearHistoryConfirmation(context)),
              const SizedBox(height: 10),
              Expanded(
                child: TransactionList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearHistoryConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF303030),
          title: Text(
            'Clear History',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to clear your history?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (historyController.transactionHistory.isEmpty) {
                  Navigator.of(context).pop();
                  Get.snackbar(
                    'No History',
                    'There are no transactions to clear.',
                    snackPosition: SnackPosition.TOP,
                    colorText: Colors.white,
                    duration: Duration(seconds: 3),
                  );
                } else {
                  historyController.clearHistory();
                  Navigator.of(context).pop();
                  Get.snackbar(
                    'History Cleared',
                    'Your transaction history has been cleared.',
                    snackPosition: SnackPosition.TOP,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text(
                'Clear',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
