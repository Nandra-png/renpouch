import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Untuk format mata uang

class HistoryController extends GetxController {
  var transactionHistory = <Map<String, dynamic>>[].obs; // Menyimpan riwayat transaksi

  // Menambahkan transaksi ke riwayat
  void addTransaction(Map<String, dynamic> transaction) {
    transactionHistory.add(transaction);
    print('Transaction added: $transaction'); 
  }

  // Menghapus transaksi dari riwayat
  void deleteTransaction(Map<String, dynamic> transaction) {
    if (transactionHistory.contains(transaction)) {
      transactionHistory.remove(transaction);
      print('Transaction deleted: $transaction'); 
    } else {
      print('Transaction not found: $transaction'); 
    }
  }

  // Menghapus semua riwayat transaksi
  void clearHistory() {
    transactionHistory.clear();
    print('Transaction history cleared');
  }

  // Format mata uang ke dalam format Rupiah (Rp)
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }
}
