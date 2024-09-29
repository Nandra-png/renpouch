import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For currency formatting

class HistoryController extends GetxController {
  var transactionHistory = <Map<String, dynamic>>[].obs;

  void addTransaction(Map<String, dynamic> transaction) {
    transactionHistory.add(transaction);
    print('Transaction added: $transaction'); 
  }


  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

 
  void deleteTransaction(Map<String, dynamic> transaction) {
    if (transactionHistory.contains(transaction)) {
      transactionHistory.remove(transaction);
      print('Transaction deleted: $transaction'); 
    } else {
      print('Transaction not found: $transaction'); 
    }
  }


  void clearHistory() {
    transactionHistory.clear();
    print('Transaction history cleared');
  }
}
