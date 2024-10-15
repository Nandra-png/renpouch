import 'package:repouch/controllers/wallet_controller.dart';

class Transaction {
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String message;

  Transaction({
    required this.type,
    required this.amount,
    required this.date,
    required this.message,
  });

  // Convert Transaction to Map
  Map<String, dynamic> toMap() {
    return {
      'type': type == TransactionType.deposit ? 'deposit' : 'withdraw',
      'amount': amount,
      'date': date.toIso8601String(),
      'message': message,
    };
  }

  // Create a Transaction from Map
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      type: map['type'] == 'deposit' ? TransactionType.deposit : TransactionType.withdraw,
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      message: map['message'],
    );
  }
}
