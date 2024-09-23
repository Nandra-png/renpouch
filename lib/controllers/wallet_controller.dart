import 'package:get/get.dart';

class WalletController extends GetxController {
  var balance = 0.0.obs;
  var transactionHistory = <Map<String, dynamic>>[].obs;


  void deposit(double amount, String message) {
    balance.value += amount;
    transactionHistory.insert(0, {
      'type': 'deposit',
      'amount': amount,
      'message': message.isNotEmpty ? message : 'No message',
      'date': DateTime.now().toString().substring(0, 10),
    });
  }

  void withdraw(double amount, String message) {
    balance.value -= amount;
    transactionHistory.insert(0, {
      'type': 'withdraw',
      'amount': amount,
      'message': message.isNotEmpty ? message : 'No message',
      'date': DateTime.now().toString().substring(0, 10),
    });
  }
}
