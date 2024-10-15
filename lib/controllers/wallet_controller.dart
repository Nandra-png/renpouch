import 'package:get/get.dart';
import 'package:repouch/local_Database/database_helper.dart';
import 'package:repouch/local_Database/transaction.dart';
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
    loadTransactions(); // Load transactions from the database
  }

  

  // Load balance dari database
  Future<void> loadBalance() async {
    balance.value = await DatabaseHelper.instance.loadBalance();
  }

  

  // Load transactions dari database
  Future<void> loadTransactions() async {
    final transactionMaps = await DatabaseHelper.instance.getAllTransactions();
    transactions.value = transactionMaps.map((map) => Transaction.fromMap(map)).toList();
    calculateMonthlyTotals(); // Calculate monthly totals after loading transactions
    loadMonthlyTotals(); // Load monthly totals from database to ensure they are up-to-date
  }

  // Simpan balance ke database
  Future<void> saveBalance() async {
    await DatabaseHelper.instance.saveBalance(balance.value);
  }

  // Load total deposit dan withdraw bulanan dari database
  Future<void> loadMonthlyTotals() async {
    final totals = await DatabaseHelper.instance.loadMonthlyTotals();
    totalDepositsThisMonth.value = totals['totalDeposits']!;
    totalWithdrawalsThisMonth.value = totals['totalWithdrawals']!;
  }

  // Simpan total deposit dan withdraw bulanan ke database
  Future<void> saveMonthlyTotals() async {
    await DatabaseHelper.instance.saveMonthlyTotals(
      totalDepositsThisMonth.value,
      totalWithdrawalsThisMonth.value,
    );
  }


  // Deposit saldo
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

  // Withdraw saldo
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

  // Hitung ulang total deposit dan withdraw bulanan
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

    saveMonthlyTotals(); // Save the calculated totals
  }
}

enum TransactionType { deposit, withdraw }
