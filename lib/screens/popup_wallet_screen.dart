import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/amountparse_controller.dart';
import 'package:repouch/controllers/wallet_controller.dart';

class WithdrawDepositPopup extends StatefulWidget {
  @override
  _WithdrawDepositPopupState createState() => _WithdrawDepositPopupState();
}

class _WithdrawDepositPopupState extends State<WithdrawDepositPopup> {
  final WalletController walletController = Get.find();
  final AmountParserController amountParserController = Get.find();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController messageController = TextEditingController(); 
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Enter amount'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          TextField(
            controller: messageController, // Input for message
            decoration: InputDecoration(labelText: 'Enter message (optional)'),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Deposit'),
                  leading: Radio<String>(
                    value: 'deposit',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Withdraw'),
                  leading: Radio<String>(
                    value: 'withdraw',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (selectedOption.isEmpty) {
                _showMessage(context, 'Error', 'Silakan pilih opsi Deposit atau Withdraw.');
                return;
              }

              String inputAmount = amountController.text.trim();
              String message = messageController.text.trim(); // Get message input
              double amount;

              try {
                amount = amountParserController.parseAmount(inputAmount);

                if (selectedOption == 'deposit') {
                  walletController.deposit(amount, message);
                  Get.back(); // Tutup popup
                  Get.snackbar('Berhasil Menabung!', 'Berhasil mencatat uang!', snackPosition: SnackPosition.BOTTOM);
                } else if (selectedOption == 'withdraw') {
                  if (walletController.balance < amount) {
                    Get.back(); // Tutup popup
                    Get.snackbar('Gagal Withdraw!', 'Uangmu habis, ayo mulai menabung.', snackPosition: SnackPosition.BOTTOM);
                  } else {
                    walletController.withdraw(amount, message);
                    Get.back(); // Tutup popup
                    Get.snackbar('Berhasil Withdraw!', 'Berhasil menarik uang!', snackPosition: SnackPosition.BOTTOM);
                  }
                }
                amountController.clear();
                messageController.clear(); // Clear the message field
              } catch (e) {
                _showMessage(context, 'Error', 'Jumlah yang dimasukkan tidak valid.');
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showMessage(BuildContext context, String title, String message) {
    showDialog(
      
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(title),
          content: Text(message),
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
