import 'package:get/get.dart';
import 'package:repouch/local_Database/sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history_controller.dart';

class WalletController extends GetxController {
  var balance = 0.0.obs;
  var totalDepositsThisMonth = 0.0.obs;
  var totalWithdrawalsThisMonth = 0.0.obs;
  var transactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBalance();
    loadMonthlyTotals();
  }

  void clearMonthlyTotals() {
    totalDepositsThisMonth.value = 0.0;
    totalWithdrawalsThisMonth.value = 0.0;
    saveMonthlyTotals();
  }

  Future<void> loadBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    balance.value = prefs.getDouble('balance') ?? 0.0;
  }

  Future<void> saveBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance.value);
  }

  Future<void> loadMonthlyTotals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    totalDepositsThisMonth.value = prefs.getDouble('totalDeposits') ?? 0.0;
    totalWithdrawalsThisMonth.value =
        prefs.getDouble('totalWithdrawals') ?? 0.0;
  }

  Future<void> saveMonthlyTotals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalDeposits', totalDepositsThisMonth.value);
    await prefs.setDouble('totalWithdrawals', totalWithdrawalsThisMonth.value);
  }

  void deposit(double amount, String message) {
    balance.value += amount;
    saveBalance();

    var transaction = Transaction(
      type: TransactionType.deposit,
      amount: amount,
      date: DateTime.now(),
      message: message.isEmpty ? 'No message' : message,
    );
    transactions.add(transaction);
    Get.find<HistoryController>().addTransaction(transaction.toMap());

    totalDepositsThisMonth.value += amount;
    saveMonthlyTotals();
    calculateMonthlyTotals();
  }

  void withdraw(double amount, String message) {
    if (balance.value >= amount) {
      balance.value -= amount;
      saveBalance();

      var transaction = Transaction(
        type: TransactionType.withdraw,
        amount: amount,
        date: DateTime.now(),
        message: message.isEmpty ? 'No message' : message,
      );
      transactions.add(transaction);
      Get.find<HistoryController>().addTransaction(transaction.toMap());

      totalWithdrawalsThisMonth.value += amount;
      saveMonthlyTotals();
      calculateMonthlyTotals();
    } else {
      print('Saldo tidak cukup untuk withdraw.');
    }
  }

  void calculateMonthlyTotals() {
    final now = DateTime.now();

    totalDepositsThisMonth.value = transactions
        .where((tx) =>
            tx.type == TransactionType.deposit &&
            tx.date.month == now.month &&
            tx.date.year == now.year)
        .fold(0.0, (sum, tx) => sum + tx.amount);

    totalWithdrawalsThisMonth.value = transactions
        .where((tx) =>
            tx.type == TransactionType.withdraw &&
            tx.date.month == now.month &&
            tx.date.year == now.year)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }
}

enum TransactionType { deposit, withdraw }
