import 'package:flutter/material.dart';
import 'package:repouch/controllers/popup_wallet_controller.dart';

class WithdrawDepositPopup extends StatefulWidget {
  @override
  _WithdrawDepositPopupState createState() => _WithdrawDepositPopupState();
}

class _WithdrawDepositPopupState extends State<WithdrawDepositPopup> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String selectedOption = 'Deposit';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStyledTextField(
                  amountController, 'Enter amount', TextInputType.number),
              SizedBox(height: 10),
              _buildStyledTextField(messageController,
                  'Enter message (optional)', TextInputType.text),
              SizedBox(height: 20),
              _buildToggleOption(),
              SizedBox(height: 20),
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
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildToggleOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton('Deposit'),
        SizedBox(width: 10),
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
          color: selectedOption == label ? Colors.greenAccent : Colors.black54,
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
        _onDoneButtonPressed();
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

  void _onDoneButtonPressed() {
    String inputAmount = amountController.text.trim();
    String message = messageController.text.trim(); 
    WithdrawDepositLogic().handleDeposit(inputAmount, message, selectedOption);
    amountController.clear();
    messageController.clear();
  }
}

void showWithdrawDepositPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return WithdrawDepositPopup();
    },
  );
}
