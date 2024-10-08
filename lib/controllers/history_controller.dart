import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:repouch/local_Database/database_helper.dart';
import 'package:repouch/widgets/HistoryModel.dart';

class HistoryController extends GetxController {
  var transactionHistory = <HistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactionHistory();
  }

  Future<void> loadTransactionHistory() async {
    final List<Map<String, dynamic>> transactions =
        await DatabaseHelper.instance.getAllTransactions();
    transactionHistory.assignAll(
        transactions.map((data) => HistoryModel.fromMap(data)).toList());
  }

  Future<void> saveTransaction(Map<String, dynamic> transaction) async {
    await DatabaseHelper.instance.insertTransaction(transaction);
    loadTransactionHistory();
  }

  void addTransaction(Map<String, dynamic> transaction) {
    saveTransaction(transaction);
    print('Transaction added: $transaction');
  }

  void deleteTransaction(Map<String, dynamic> transaction) async {
    await DatabaseHelper.instance.deleteTransaction(transaction['id']);
    loadTransactionHistory();
  }

  void clearHistory() async {
    await DatabaseHelper.instance.clearTransactions();
    loadTransactionHistory();
  }

  String formatCurrency(double amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }
}
