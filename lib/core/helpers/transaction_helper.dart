
import 'package:flutter/material.dart';

class TransactionHelper {
  static Color getColor(String type) {
    switch (type.toLowerCase()) {
      case 'invoice':
        return Colors.green;
      case 'payment':
        return Colors.orange;
      case 'deposit':
        return Colors.blue;
      case 'withdrawal':
        return Colors.red;
      case 'transfer':
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }

  static String getAbbreviation(String type) {
    if (type.isEmpty) return 'N';

    final lowerType = type.toLowerCase();
    if (lowerType == 'invoice') return 'I';
    if (lowerType == 'payment') return 'P';
    if (lowerType == 'deposit') return 'D';
    if (lowerType == 'withdrawal') return 'W';
    if (lowerType == 'transfer') return 'T';

    return type[0].toUpperCase();
  }
}