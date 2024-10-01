import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'history_controller.dart';

class WalletController extends GetxController {
  var balance = 0.0.obs; // Untuk menyimpan saldo
  var totalDepositsThisMonth = 0.0.obs; // Total deposit bulan ini
  var totalWithdrawalsThisMonth = 0.0.obs; // Total withdraw bulan ini

  var transactions = <Transaction>[].obs;

  void deposit(double amount, String message) {
    balance.value += amount;

    // Tambahkan transaksi deposit ke history
    var transaction = Transaction(
      type: TransactionType.deposit,
      amount: amount,
      date: DateTime.now(),
      message: message.isEmpty ? 'No message' : message,
    );
    transactions.add(transaction);
    Get.find<HistoryController>().addTransaction(transaction.toMap());

    calculateMonthlyTotals();
  }

  // Fungsi untuk withdraw
  void withdraw(double amount, String message) {
    if (balance.value >= amount) {
      balance.value -= amount;

      // Tambahkan transaksi withdraw ke history
      var transaction = Transaction(
        type: TransactionType.withdraw,
        amount: amount,
        date: DateTime.now(),
        message: message.isEmpty ? 'No message' : message,
      );
      transactions.add(transaction);
      Get.find<HistoryController>().addTransaction(transaction.toMap());

      calculateMonthlyTotals(); // Hitung total bulan ini
    } else {
      print('Saldo tidak cukup untuk withdraw.');
    }
  }

  // Method untuk menghitung total deposit dan withdraw bulan ini
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

  // Method untuk meng-clear total deposit dan withdraw
  void clearTotals() {
    totalDepositsThisMonth.value = 0;
    totalWithdrawalsThisMonth.value = 0;
  }
}

// Model transaksi
class Transaction {
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String message;

  Transaction({
    required this.amount,
    required this.date,
    required this.type,
    required this.message,
  });

  // Convert to Map for history logging
  Map<String, dynamic> toMap() {
    return {
      'type': type == TransactionType.deposit ? 'deposit' : 'withdraw',
      'amount': amount,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'message': message,
    };
  }
}

// Enum untuk tipe transaksi
enum TransactionType { deposit, withdraw }
