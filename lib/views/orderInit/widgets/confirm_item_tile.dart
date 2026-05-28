import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/models/cart_model/item.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';

class ConfirmItemTile extends StatelessWidget {
  final Item item;

  const ConfirmItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final totalPrice = (item.totalPrice ?? 0).toDouble();
    final discount = double.tryParse(item.discountAmount ?? '0') ?? 0;
    final finalPrice = double.tryParse(item.finalItemPrice ?? '') ?? 0;
    final hasDiscount = discount > 0;
    final hasFinal = finalPrice != totalPrice;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product info
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.title ?? tr('order_init.unknown_product'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (item.option?.optionName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${tr('order_init.option')}: ${item.option!.optionName!}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
                if (item.packaging?.title != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${tr('order_init.packaging')}: ${item.packaging!.title!}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
                if (item.packaging?.color?.degree != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${tr('order_init.color')}: ${item.packaging!.color!.degree!}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      ColorDot(
                        color: parseColorDegree(item.packaging!.color!.degree!),
                        selected: false,
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Quantity
          Expanded(
            flex: 1,
            child: Text(
              '${tr('order_init.qty')}: ${item.quantityPerUnit}',
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),

          // Price
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatPrice(totalPrice),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
                if (hasDiscount)
                  Text(
                    '- ${formatPrice(discount)}',
                    style: const TextStyle(fontSize: 11, color: Colors.green),
                    textAlign: TextAlign.right,
                  ),
                if (hasFinal)
                  Text(
                    formatPrice(finalPrice),
                    style: const TextStyle(fontSize: 11),
                    textAlign: TextAlign.right,
                  ),
                if (item.pointsEarned != null && item.pointsEarned! > 0)
                  Text(
                    '+ ${item.pointsEarned!.toInt()} ${tr('order_init.points_earned')}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.amber,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
