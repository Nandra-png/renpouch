import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/amountparse_controller.dart';
import 'package:repouch/controllers/wallet_controller.dart';
import 'package:intl/intl.dart';

class WithdrawDepositPopup extends StatefulWidget {
  @override
  _WithdrawDepositPopupState createState() => _WithdrawDepositPopupState();
}

class _WithdrawDepositPopupState extends State<WithdrawDepositPopup> {
  final WalletController walletController = Get.find();
  final AmountParserController amountParserController = Get.find();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String selectedOption = 'Deposit'; // Default selection

  // Function to format amount with currency
  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors
            .blueGrey[800], // Match this with your screen's background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        // Wrapped in SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom), // Adjusts for keyboard height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Amount Input
              _buildStyledTextField(
                  amountController, 'Enter amount', TextInputType.number),
              SizedBox(height: 10),

              // Message Input
              _buildStyledTextField(messageController,
                  'Enter message (optional)', TextInputType.text),
              SizedBox(height: 20),

              // Toggle for Deposit/Withdraw
              _buildToggleOption(),
              SizedBox(height: 20),

              // Done Button
              _buildStyledButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField(TextEditingController controller, String label,
      TextInputType keyboardType) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white), // Label color
        filled: true,
        fillColor: Colors.black54, // Background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white), // Focus border color
        ),
      ),
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white), // Text color
    );
  }

  Widget _buildToggleOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center alignment
      children: [
        _buildToggleButton('Deposit'),
        SizedBox(width: 10), // Closer spacing
        _buildToggleButton('Withdraw'),
      ],
    );
  }

  Widget _buildToggleButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selectedOption == label
              ? Colors.greenAccent
              : Colors.black54, // Updated selected color
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedOption == label ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStyledButton() {
    return ElevatedButton(
      onPressed: () {
        String inputAmount = amountController.text.trim();
        String message = messageController.text.trim(); // Get message input

        // Check if the amount is empty
        if (inputAmount.isEmpty) {
          Get.snackbar(
            'Peringatan',
            'Silakan masukkan jumlah yang valid.',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3), // Snack bar duration
          );
          return;
        }

        double amount;
        try {
          amount = amountParserController.parseAmount(inputAmount);

          if (selectedOption == 'Deposit') {
            walletController.deposit(amount, message);
            Get.back();
            Get.snackbar(
              'Berhasil Menabung!',
              'Berhasil mencatat uang sebanyak ${formatCurrency(amount)}.',
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            );
          } else if (selectedOption == 'Withdraw') {
            if (walletController.balance < amount) {
              Get.back();
              Get.snackbar(
                'Gagal Withdraw!',
                'Uangmu habis, ayo mulai menabung.',
                snackPosition: SnackPosition.TOP,
                colorText: Colors.white,
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              );
            } else {
              walletController.withdraw(amount, message);
              Get.back();
              Get.snackbar(
                'Berhasil Withdraw!',
                'Berhasil menarik uang sebanyak ${formatCurrency(amount)}.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: Duration(seconds: 3),
              );
            }
          }
          amountController.clear();
          messageController.clear();
        } catch (e) {
          Get.snackbar(
            'Error',
            'Jumlah yang dimasukkan tidak valid.',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          );
        }
      },
      child: Text('Done'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.greenAccent,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

void showWithdrawDepositPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Enables scrolling
    isDismissible: true, // Allow dismissing
    backgroundColor: Colors.transparent, // Makes the background transparent
    builder: (BuildContext context) {
      return WithdrawDepositPopup();
    },
  );
}
