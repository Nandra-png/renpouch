import 'package:get/get.dart';

class AmountParserController extends GetxController {
  double parseAmount(String input) {
    double amount = 0.0;
    if (input.isEmpty) return amount;

    input = input.toLowerCase();
    if (input.contains('jt')) {
      amount = double.parse(input.replaceAll('jt', '').trim()) * 1000000;
    } else if (input.contains('m')) {
      amount = double.parse(input.replaceAll('m', '').trim()) * 1000000;
    } else if (input.contains('rb')) {
      amount = double.parse(input.replaceAll('rb', '').trim()) * 1000;
    } else if (input.contains('k')) {
      amount = double.parse(input.replaceAll('k', '').trim()) * 1000;
    } else {
      amount = double.parse(input);
    }

    return amount;
  }
}
