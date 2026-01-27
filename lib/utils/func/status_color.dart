import 'package:flutter/material.dart';

Color getStatusColor(String statusLabel) {
  switch (statusLabel) {
    case 'deleverd':
      return const Color(0xFF16A34A);
    case 'pending':
      return const Color(0xFF2563EB);
    case 'assined_to_driver':
      return const Color(0xFFF59E0B);
    case 'canceled':
      return const Color(0xFFD81D10);
    default:
      return Colors.grey;
  }
}
