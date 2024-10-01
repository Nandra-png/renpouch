import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:repouch/controllers/amountparse_controller.dart';
import 'package:repouch/controllers/wallet_controller.dart';
import 'package:repouch/screens/popup_wallet_screen.dart';

class WalletScreen extends StatelessWidget {
  final WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    Get.put(AmountParserController());

    return Scaffold(
      backgroundColor: const Color(0xDE000000),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Positioned(
              left: 56,
              top: 100,
              child: Container(
                width: 319,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ren',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Pouch',
                        style: TextStyle(
                          color: const Color(0xFFF2D752),
                          fontSize: 45,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Header section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width - 10,
              height: 250,
              child: Stack(
                children: [
                  // Background layers
                  Positioned(
                    left: 0,
                    top: 48.91,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 201.09,
                      decoration: BoxDecoration(
                        color: const Color(0xFF262429),
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: 182.97,
                      decoration: BoxDecoration(
                        color: const Color(0xFF18E799),
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                  // Balance display
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 43,
                    child: Obx(() {
                      String formattedBalance = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(walletController.balance.value);

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          // Set the font size based on the available width
                          double fontSize = constraints.maxWidth > 319
                              ? 50
                              : 30; // Adjust sizes as needed

                          return Center(
                            child: SizedBox(
                              width: 319,
                              height: 57.48,
                              child: Text(
                                formattedBalance,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontSize,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  // Labels
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 127,
                    child: const Center(
                      child: SizedBox(
                        width: 163,
                        height: 28.74,
                        child: Text(
                          'Current Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        width: 250,
                        height: 28.74,
                        child: Text(
                          '${DateFormat('EEEE, dd/MM/yy').format(DateTime.now())}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Fixed bottom section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Clear Totals Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showClearConfirmation(context);
                        },
                        child: const Text(
                          'Clear Totals',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Card for Deposit
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF262429),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Deposit This Month',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Text(
                            'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(walletController.totalDepositsThisMonth.value)}',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  // Card for Withdraw
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF262429),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Withdraw This Month',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Text(
                            'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(walletController.totalWithdrawalsThisMonth.value)}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showWithdrawDepositPopup(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showWithdrawDepositPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return WithdrawDepositPopup();
      },
    );
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF303030),
          title: Text(
            "Clear Totals",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Are you sure you want to clear the totals?",
            style: TextStyle(color: Colors.white70),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                "Clear",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // Call the clearTotals method in your wallet controller
                walletController.clearTotals();
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Totals cleared!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
              ),
            ),
          ],
        );
      },
    );
  }
}
