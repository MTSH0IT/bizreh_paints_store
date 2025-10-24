import 'package:flutter/material.dart';

class PointsHistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final int points; // positive for earned, negative for spent

  const PointsHistoryItem({
    super.key,
    required this.title,
    required this.date,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = points >= 0;
    final color = isPositive
        ? const Color(0xFF16A34A)
        : const Color(0xFFDC2626);
    final sign = isPositive ? '+' : '-';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isPositive
                  ? color.withValues(alpha: 0.05)
                  : color.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPositive ? Icons.add : Icons.remove,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '$sign${points.abs()}',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
