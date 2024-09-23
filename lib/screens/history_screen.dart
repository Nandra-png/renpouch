import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/wallet_controller.dart';

class HistoryScreen extends StatelessWidget {
  final WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        backgroundColor: Colors.black87, // AppBar background color
      ),
      body: Container(
        color: Colors.black87, // Background color for the entire screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Transactions',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white, // Title color
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: walletController.transactionHistory.length,
                  itemBuilder: (context, index) {
                    final transaction = walletController.transactionHistory[index];
                    bool isDeposit = transaction['type'] == 'deposit';

                    return GestureDetector(
                      onTap: () {
                        _showTransactionDetails(context, transaction);
                      },
                      child: Card(
                        color: Colors.grey[850], // Card background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isDeposit ? Colors.green : Colors.red, // Avatar color
                            child: Icon(
                              isDeposit ? Icons.arrow_upward : Icons.arrow_downward,
                              color: Colors.white, // Icon color
                            ),
                          ),
                          title: Text(
                            isDeposit ? 'Deposit' : 'Withdraw',
                            style: TextStyle(
                              color: Colors.white, // Title text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp${transaction['amount']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70, // Amount text color
                                ),
                              ),
                              Text(
                                transaction['date'],
                                style: TextStyle(color: Colors.white70), // Date text color
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, Map<String, dynamic> transaction) {
    bool isDeposit = transaction['type'] == 'deposit';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDeposit ? Colors.green[200] : Colors.red[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
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
              Text('Amount: Rp${transaction['amount']}', style: TextStyle(color: Colors.black)),
              SizedBox(height: 8),
              Text('Date: ${transaction['date']}', style: TextStyle(color: Colors.black)),
              SizedBox(height: 8),
              Text('Message: ${transaction['message']}', style: TextStyle(color: Colors.black)),
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
