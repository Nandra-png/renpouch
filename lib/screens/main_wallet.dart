  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:intl/intl.dart';
  import 'package:repouch/controllers/amountparse_controller.dart';
  import 'package:repouch/controllers/wallet_controller.dart';
  import 'package:repouch/screens/popup_wallet_screen.dart';
  import 'package:repouch/widgets/balance_display.dart';
  import 'package:repouch/widgets/transaction_wallet.dart';

  class WalletScreen extends StatelessWidget {
    final WalletController walletController = Get.put(WalletController());

    @override
    Widget build(BuildContext context) {
      Get.put(AmountParserController());

      return Scaffold(
        backgroundColor: Colors.black87,
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
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(37),
                        ),
                      ),
                    ),
                    // Balance display
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 60,
                      child: BalanceDisplay(),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TransactionCard(
                      title: 'Total Deposit This Month',
                      amount: walletController.totalDepositsThisMonth,
                      color: Colors.green,
                    ),
                    TransactionCard(
                      title: 'Total Withdraw This Month',
                      amount: walletController.totalWithdrawalsThisMonth,
                      color: Colors.red,
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
  }
