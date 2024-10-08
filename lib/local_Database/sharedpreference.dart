import 'package:intl/intl.dart';
import 'package:repouch/controllers/wallet_controller.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'type': type == TransactionType.deposit ? 'deposit' : 'withdraw',
      'amount': amount,
      'date': DateFormat('yyyy-MM-dd').format(date),
      'message': message,
    };
  }
}
