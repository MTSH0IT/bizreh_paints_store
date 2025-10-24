import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    required this.amount,
    this.emphasis = false,
    this.color,
  });

  final String label;
  final double amount;
  final bool emphasis;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: emphasis ? 18 : 16,
      fontWeight: emphasis ? FontWeight.w700 : FontWeight.w500,
      color: color,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(_format(amount), style: style),
        ],
      ),
    );
  }

  String _format(double value) {
    final prefix = value < 0 ? '-' : '';
    final abs = value.abs().toStringAsFixed(2);
    return '$prefix\$$abs';
  }
}
