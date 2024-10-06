import 'package:flutter/material.dart';
import 'package:repouch/controllers/popup_wallet_controller.dart';
import 'package:repouch/widgets/Textfield.dart';
import 'package:repouch/widgets/toggle_option_wd.dart';

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
              StyledTextField(
                controller: amountController,
                label: 'Enter amount',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              StyledTextField(
                controller: messageController,
                label: 'Enter message (optional)',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              ToggleOption(
                selectedOption: selectedOption,
                onOptionSelected: (option) {
                  setState(() {
                    selectedOption = option;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildStyledButton(),
            ],
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
