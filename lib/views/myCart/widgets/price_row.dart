import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';

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
      fontSize: emphasis ? 16 : 14,
      fontWeight: emphasis ? FontWeight.w700 : FontWeight.w500,
      color: color,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
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
    final abs = formatPrice(value.abs());
    return '$prefix \$$abs';
  }
}
