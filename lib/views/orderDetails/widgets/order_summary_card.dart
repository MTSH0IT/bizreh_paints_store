import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final summary = order.financialSummary;
    final subTotal = summary?.subTotal;
    final totalDiscount = summary?.totalDiscount;
    final total = summary?.total;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('order_details.order_summary'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (summary != null) ...[
              _buildSummaryRow(
                tr('order_details.sub_total'),
                formatPriceWithSymbol(subTotal, symbol: '\$'),
              ),
              const SizedBox(height: 8),
              _buildSummaryRow(
                tr('order_details.total_discount'),
                '- ${formatPriceWithSymbol(totalDiscount, symbol: '\$')}',
              ),
              const SizedBox(height: 8),
            ],
            _buildSummaryRow(
              tr('order_details.total'),
              formatPriceWithSymbol(total, symbol: '\$'),
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.black : Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.black : null,
          ),
        ),
      ],
    );
  }
}
