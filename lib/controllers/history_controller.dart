import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Untuk memformat mata uang

class HistoryController extends GetxController {
  // List yang menampung history transaksi
  var transactionHistory = <Map<String, dynamic>>[].obs;

  void addTransaction(Map<String, dynamic> transaction) {
    transactionHistory.add(transaction);
    print('Transaction added: $transaction'); // Debugging
  }

  // Fungsi untuk memformat jumlah uang dalam format IDR
  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

  // Metode untuk menghapus transaksi tertentu
  void deleteTransaction(Map<String, dynamic> transaction) {
    // Hanya hapus jika transaksi ada di dalam daftar
    if (transactionHistory.contains(transaction)) {
      transactionHistory.remove(transaction);
      print('Transaction deleted: $transaction'); // Debugging
    } else {
      print(
          'Transaction not found: $transaction'); // Debugging jika tidak ditemukan
    }
  }

  // Metode untuk menghapus seluruh riwayat transaksi
  void clearHistory() {
    transactionHistory.clear();
    print('Transaction history cleared'); // Debugging
  }
}
