import 'package:flutter/material.dart';

class OrderIdCard extends StatelessWidget {
  final String orderNo;
  final String datePlaced;
  final String dateDelivered;
  final String statusLabel;

  const OrderIdCard({
    super.key,
    required this.orderNo,
    required this.datePlaced,
    required this.dateDelivered,
    required this.statusLabel,
  });

  Color get statusColor {
    switch (statusLabel) {
      case 'Delivered':
        return const Color(0xFF16A34A);
      case 'Shipped':
        return const Color(0xFFF59E0B);
      case 'Processing':
        return const Color(0xFF2563EB);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #$orderNo',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),

                    Text(
                      statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.black26, thickness: 1),
            const SizedBox(height: 8),
            Text(
              "Date Placed: $datePlaced",
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              "Date Delivered: $dateDelivered",
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
