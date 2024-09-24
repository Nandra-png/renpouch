import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'history_controller.dart'; 

class WalletController extends GetxController {
  var balance = 0.0.obs; 


  void deposit(double amount, String message) {
    balance.value += amount;


    Get.find<HistoryController>().addTransaction({
      'type': 'deposit',
      'amount': amount,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()), 
      'message': message.isEmpty ? 'No message' : message, 
    });
  }


  void withdraw(double amount, String message) {
    if (balance.value >= amount) {
      balance.value -= amount;

      // Tambahkan transaksi withdraw ke history
      Get.find<HistoryController>().addTransaction({
        'type': 'withdraw',
        'amount': amount,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()), // Format tanggal
        'message': message.isEmpty ? 'No message' : message, // Pesan opsional
      });
    } else {
      print('Saldo tidak cukup untuk withdraw.');
    }
  }
}
