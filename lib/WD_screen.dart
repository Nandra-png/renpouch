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
  String selectedOption = 'deposit'; // default selection

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
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ListTile(
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
                ListTile(
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
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String inputAmount = amountController.text.replaceAll('.', '').replaceAll(',', ''); 

                try {
                  double amount = double.parse(inputAmount); // Konversi string ke double
                  if (selectedOption == 'deposit') {
                    walletController.deposit(amount);
                    _showMessage(context, 'Berhasil Menabung!',
                        'Wow, bagus! Kamu berhasil menabung banyak uang!');
                  } else if (selectedOption == 'withdraw') {
                    if (walletController.balance < amount) {
                      _showMessage(context, 'Gagal Withdraw!',
                          'Uangmu hampir habis, ayo mulai menabung.');
                    } else {
                      walletController.withdraw(amount);
                      _showMessage(context, 'Berhasil Withdraw!',
                          'Kamu berhasil melakukan withdraw.');
                    }
                  }
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

  // Fungsi untuk menampilkan pop-up
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
                Navigator.of(context).pop(); // Tutup pop-up
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
