import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/history_controller.dart';
import 'package:repouch/controllers/wallet_controller.dart';
import 'package:intl/intl.dart'; // Import NumberFormat

class HistoryScreen extends StatelessWidget {
  final WalletController walletController = Get.find();
  final HistoryController historyController =
      Get.find(); // Tambahkan ini untuk mendapatkan controller

  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87, // Background color for the entire screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Transactions',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white, // Title color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showClearHistoryConfirmation(context);
                    },
                    child: Text(
                      'Clear History',
                      style: TextStyle(
                        color: Colors.grey, // Gray color for the label
                        decoration:
                            TextDecoration.lineThrough, // Strikethrough effect
                        fontSize: 16, // Optional: Adjust font size
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  // Balikkan urutan transaksi untuk menampilkan yang terbaru di atas
                  var transactions =
                      List.from(historyController.transactionHistory.reversed);

                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      bool isDeposit = transaction['type'] == 'deposit';

                      return GestureDetector(
                        onTap: () {
                          _showTransactionDetails(context, transaction);
                        },
                        child: Card(
                          color: Colors.grey[850],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  isDeposit ? Colors.green : Colors.red,
                              child: Icon(
                                isDeposit
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.white, // Icon color
                              ),
                            ),
                            title: Text(
                              isDeposit ? 'Deposit' : 'Withdraw',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Format the amount with commas
                                Text(
                                  formatCurrency(transaction['amount']),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  transaction['date'],
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert, color: Colors.white),
                              color: const Color.fromARGB(255, 255, 44,
                                  44), // Background color of the popup
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors
                                            .white), // Change the text color to white
                                  ),
                                  value: 'delete',
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'delete') {
                                  // Hapus transaksi
                                  historyController
                                      .deleteTransaction(transaction);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
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
          backgroundColor: Colors.grey[850], // Dark background for the dialog
          title: Text(
            'Clear History',
            style: TextStyle(color: Colors.white), // Title color
          ),
          content: Text(
            'Are you sure you want to clear your history?',
            style: TextStyle(color: Colors.white70), // Content color
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white), // Cancel button color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                historyController.clearHistory(); // Clear history
                Navigator.of(context).pop(); // Close the dialog

                // Show Snackbar
                Get.snackbar(
                  'History Cleared',
                  'Your transaction history has been cleared.',
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.white, // Text color for the Snackbar
                );
              },
              child: Text(
                'Clear',
                style: TextStyle(
                    color: Colors.white), // Change text color to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color for the button
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTransactionDetails(
      BuildContext context, Map<String, dynamic> transaction) {
    bool isDeposit = transaction['type'] == 'deposit';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDeposit ? Colors.greenAccent : Colors.red[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                isDeposit ? Icons.arrow_upward : Icons.arrow_downward,
                color: isDeposit ? Colors.green : Colors.red,
              ),
              SizedBox(width: 8),
              Text('${isDeposit ? "Deposit" : "Withdraw"} Details'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amount: ${formatCurrency(transaction['amount'])}',
                  style: TextStyle(color: Colors.black)),
              SizedBox(height: 8),
              Text('Date: ${transaction['date']}',
                  style: TextStyle(color: Colors.black)),
              SizedBox(height: 8),
              Text('Message: ${transaction['message']}',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
