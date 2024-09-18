import 'package:get/get.dart';

class WalletController extends GetxController {
  var balance = 0.0.obs;

  void deposit(double amount) {
    balance.value += amount;
  }

  void withdraw(double amount) {
    if (balance.value >= amount) {
      balance.value -= amount;
    }
  }
}
