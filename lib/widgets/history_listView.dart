import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/history_controller.dart';
import 'package:repouch/widgets/HistoryCard.dart';

class HistoryListview extends StatelessWidget {
  final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var transactions =
          List.from(historyController.transactionHistory.reversed);
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return HistoryCard(transaction: transaction);
        },
      );
    });
  }
}
