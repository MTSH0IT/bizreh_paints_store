import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/points_history_model.dart';

class PointsHistoryItem extends StatelessWidget {
  final PointsHistoryModel item;
  final VoidCallback? onTap;

  const PointsHistoryItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final referenceType = (item.referenceType ?? '').trim();
    final date = formatDate(item.createdAt);

    String title = referenceType;
    if (title.isEmpty) {
      title = '---';
    }

    String subtitle = '';
    if ((item.orderId ?? 0) > 0) {
      subtitle = 'Order #${item.orderId}';
    } else if ((item.userGiftId ?? 0) > 0) {
      subtitle = 'Gift #${item.userGiftId}';
    }

    final points = item.points ?? 0;
    final isPositive = item.pointsType != 'spent';
    final color = isPositive
        ? const Color(0xFF16A34A)
        : const Color(0xFFDC2626);
    //final sign = isPositive ? '+' : '-';

    final content = Container(
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
              color: color.withValues(alpha: 0.05),
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
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  date,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$points',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: content,
    );
  }
}
