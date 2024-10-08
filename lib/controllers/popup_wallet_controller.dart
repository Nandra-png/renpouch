import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'wallet_controller.dart';
import 'amountparse_controller.dart';

class WithdrawDepositController extends GetxController {
  final WalletController walletController = Get.find();
  final AmountParserController amountParserController = Get.find();

  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

  void handleDeposit(
      String inputAmount, String message, String selectedOption) {
    if (inputAmount.isEmpty) {
      _showSnackbar('Warning', 'Please enter a valid amount.', Colors.red);
      return;
    }

    double amount;
    try {
      amount = amountParserController.parseAmount(inputAmount);

      if (selectedOption == 'Deposit') {
        walletController.deposit(amount, message);
        Get.back();
        _showSnackbar(
            'Successfully Deposited!',
            'Successfully recorded an amount of ${formatCurrency(amount)}',
            Colors.green);
      } else if (selectedOption == 'Withdraw') {
        if (walletController.balance < amount) {
          Get.back();
          _showSnackbar('Withdrawal Failed!',
              'You have insufficient funds, please start saving.', Colors.red);
        } else {
          walletController.withdraw(amount, message);
          Get.back();
          _showSnackbar(
              'Successfully Withdrawn!',
              'Successfully withdrew an amount of ${formatCurrency(amount)}',
              Colors.red);
        }
      }
    } catch (e) {
      _showSnackbar('Error', 'The entered amount is not valid.', Colors.red);
    }
  }

  void _showSnackbar(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
    );
  }
}
