import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan ini
import 'dart:convert'; // Tambahkan ini untuk JSON encoding/decoding

class HistoryController extends GetxController {
  var transactionHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactionHistory(); // Panggil loadTransactionHistory saat inisialisasi
  }

  Future<void> loadTransactionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyJson = prefs
        .getString('transactionHistory'); // Muat riwayat dari SharedPreferences
    if (historyJson != null) {
      // Jika ada data, decode JSON ke dalam list
      List<dynamic> decodedList = json.decode(historyJson);
      transactionHistory.value = List<Map<String, dynamic>>.from(decodedList);
    }
  }

  Future<void> saveTransactionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Encode daftar transaksi ke dalam JSON dan simpan ke SharedPreferences
    await prefs.setString(
        'transactionHistory', json.encode(transactionHistory));
  }

  void addTransaction(Map<String, dynamic> transaction) {
    transactionHistory.add(transaction);
    print('Transaction added: $transaction');
    saveTransactionHistory(); // Simpan riwayat setiap kali ada transaksi baru
  }

  void deleteTransaction(Map<String, dynamic> transaction) {
    if (transactionHistory.contains(transaction)) {
      transactionHistory.remove(transaction);
      print('Transaction deleted: $transaction');
      saveTransactionHistory(); // Simpan riwayat setelah transaksi dihapus
    } else {
      print('Transaction not found: $transaction');
    }
  }

  void clearHistory() {
    transactionHistory.clear();
    print('Transaction history cleared');
    saveTransactionHistory(); // Simpan riwayat setelah dihapus
  }

  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }
}
