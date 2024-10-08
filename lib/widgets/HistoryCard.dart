import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/history_controller.dart';
import 'package:repouch/widgets/HistoryModel.dart';

class HistoryCard extends StatelessWidget {
  final HistoryModel transaction;

  HistoryCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isDeposit = transaction.type == 'deposit';
    final String formattedAmount =
        Get.find<HistoryController>().formatCurrency(transaction.amount);

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
            backgroundColor: isDeposit ? Colors.green : Colors.red,
            child: Icon(
              isDeposit ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.white,
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
              Text(
                formattedAmount,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              Text(
                transaction.date,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          trailing: PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            color: const Color.fromARGB(255, 255, 44, 44),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                value: 'delete',
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                Get.find<HistoryController>()
                    .deleteTransaction(transaction.toMap());
              }
            },
          ),
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, HistoryModel transaction) {
    bool isDeposit = transaction.type == 'deposit';

    final String formattedAmount =
        Get.find<HistoryController>().formatCurrency(transaction.amount);

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
              Text('${isDeposit ? "Deposit" : "Withdraw"}',
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount : $formattedAmount',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                'Message: ${transaction.message}',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                '${transaction.date}',
                style: TextStyle(color: Colors.black),
              ),
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
