import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/func/status_color.dart';

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
                        color: getStatusColor(statusLabel),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),

                    Text(
                      statusLabel,
                      style: TextStyle(
                        color: getStatusColor(statusLabel),
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
