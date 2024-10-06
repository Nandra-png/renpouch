import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  final VoidCallback onClearHistory;

  HistoryHeader({required this.onClearHistory});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your Transactions',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onClearHistory,
          child: Text(
            'Clear History',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
