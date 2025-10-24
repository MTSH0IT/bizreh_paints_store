import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

class DiscountOptionTile extends StatelessWidget {
  const DiscountOptionTile({
    super.key,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String subtitle;
  final double amount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? primaryColor : Colors.black12),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? primaryColor : Colors.black26,
                  width: selected ? 6 : 2,
                ),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            Text(
              _format(amount),
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _format(double value) {
    final sign = value < 0 ? '-' : '';
    final abs = value.abs().toStringAsFixed(2);
    return '$sign\$$abs';
  }
}
