class HistoryModel {
  int? id;
  String type; 
  double amount;
  String date;
  String message;

  HistoryModel({
    this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.message,
  });


  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      date: map['date'],
      message: map['message'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date,
      'message': message,
    };
  }
}
