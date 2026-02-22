import 'package:bizreh_paints_store/models/cart_model/summary.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/myCart/widgets/price_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({
    super.key,
    required this.summary,
    required this.onCheckout,
  });

  final Summary? summary;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final subtotal = (summary?.subtotal ?? 0).toDouble();
    final discount = (summary?.discountAmount ?? 0).toDouble();
    // final delivery = (summary?.deliveryFee ?? 0).toDouble();
    final total = (summary?.totalAmount ?? 0).toDouble();
    final itemsCount = summary?.itemsCount;
    final totalItems = summary?.totalItems;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            PriceRow(label: 'cart.subtotal'.tr(), amount: subtotal),
            //PriceRow(label: 'Delivery Fee', amount: delivery),
            PriceRow(label: 'cart.discount'.tr(), amount: -discount),
            const Divider(),
            PriceRow(
              label: 'cart.total'.tr(),
              amount: total,
              emphasis: true,
              color: primaryColor,
            ),
            if (itemsCount != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  'cart.items_count'.tr(args: ['$totalItems']),

                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ),

            MainButton(title: 'cart.place_order'.tr(), onPressed: onCheckout),
          ],
        ),
      ),
    );
  }
}
