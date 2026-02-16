import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/status_color.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderHistoryItem extends StatelessWidget {
  final String orderNo;
  final String date;
  final num amount;
  final String statusLabel;
  final VoidCallback onAction;
  final VoidCallback? onCancel;

  const OrderHistoryItem({
    super.key,
    required this.orderNo,
    required this.date,
    required this.amount,
    required this.statusLabel,
    required this.onAction,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'orders.history.order_no'.tr(args: [orderNo]),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formatPriceWithSymbol(amount, symbol: '\$'),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
              Expanded(
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: getOrderStatusColor(statusLabel),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (statusLabel == 'pending' && onCancel != null) ...[
                TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                  ),
                  child: Text(
                    'orders.history.cancel'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(foregroundColor: primaryColor),
                child: Text(
                  'orders.history.view_details'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
