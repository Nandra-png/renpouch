import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/wallet_controller.dart';

class WithdrawDepositScreen extends StatefulWidget {
  @override
  _WithdrawDepositScreenState createState() => _WithdrawDepositScreenState();
}

class _WithdrawDepositScreenState extends State<WithdrawDepositScreen> {
  final WalletController walletController = Get.find();
  final TextEditingController amountController = TextEditingController();
  String selectedOption = ''; // Set default value to empty

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Withdraw / Deposit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Enter amount'),
              keyboardType: TextInputType.text, // Change to text to support letters
              inputFormatters: [
                // Optionally, add input formatters here
              ],
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
                if (selectedOption.isEmpty) { // Check if no option is selected
                  _showMessage(context, 'Error', 'Silakan pilih opsi Deposit atau Withdraw.');
                  return;
                }

                String inputAmount = amountController.text.trim();
                double amount;

                try {
                  amount = _parseAmount(inputAmount); // Convert text to number
                  
                  if (selectedOption == 'deposit') {
                    walletController.deposit(amount);
                    _showMessage(context, 'Berhasil Menabung!', 'Berhasil memasukkan uang!');
                  } else if (selectedOption == 'withdraw') {
                    if (walletController.balance < amount) {
                      _showMessage(context, 'Gagal Withdraw!', 'Uangmu habis, ayo mulai menabung.');
                    } else {
                      walletController.withdraw(amount);
                      _showMessage(context, 'Berhasil Withdraw!', 'Berhasil mengeluarkan uang.');
                    }
                  }
                  amountController.clear(); // Clear TextEditingController
                } catch (e) {
                  _showMessage(context, 'Error', 'Jumlah yang dimasukkan tidak valid');
                }
              },
              child: Text('Done'),
            )
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mengonversi teks singkatan menjadi angka
  double _parseAmount(String input) {
    double amount = 0.0;
    if (input.isEmpty) return amount;

    input = input.toLowerCase();
    if (input.contains('jt')) {
      amount = double.parse(input.replaceAll('jt', '').trim()) * 1000000;
    } else if (input.contains('m')) {
      amount = double.parse(input.replaceAll('m', '').trim()) * 1000000;
    } else if (input.contains('rb')) {
      amount = double.parse(input.replaceAll('rb', '').trim()) * 1000;
    } else if (input.contains('k')) {
      amount = double.parse(input.replaceAll('k', '').trim()) * 1000;
    } else {
      amount = double.parse(input);
    }

    return amount;
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
