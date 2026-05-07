import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/func/status_color.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderIdCard extends StatelessWidget {
  final OrderModel order;
  final String datePlaced;

  const OrderIdCard({super.key, required this.order, required this.datePlaced});

  @override
  Widget build(BuildContext context) {
    final orderNo = order.orderNumber ?? order.id?.toString() ?? '';
    final statusLabel = order.status ?? '';
    final paymentStatus = order.paymentStatus;

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
                  tr('order_details.order_no', args: [orderNo]),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: getOrderStatusColor(statusLabel),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),

                    Text(
                      tr('status.$statusLabel'),
                      style: TextStyle(
                        color: getOrderStatusColor(statusLabel),
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
              "${tr('order_details.date_placed')}: $datePlaced",
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            if (paymentStatus != null && paymentStatus.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                "${tr('order_details.payment')}: ${tr('status.$paymentStatus')}",
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
