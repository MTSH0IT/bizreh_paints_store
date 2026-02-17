import 'package:bizreh_paints_store/models/order_model/item.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final items = order.items ?? <Item>[];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'order_details.items_ordered'.tr(),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _ItemOrder(item: items[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.black26, thickness: 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemOrder extends StatelessWidget {
  const _ItemOrder({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: item.product?.title,
      ar: item.product?.arTitle,
      fallback: '',
    );
    final quantity = item.quantityPerUnit ?? 0;
    final price = (item.totalPrice ?? 0).toDouble();
    final optionName = context.localizedValue(
      en: item.productOption?.optionName,
      ar: item.productOption?.arOptionName,
      fallback: '',
    );
    final packagingTitle = context.localizedValue(
      en: item.packaging?.title,
      ar: item.packaging?.arTitle,
      fallback: '',
    );
    final colorDegree = item.color?.degree;
    final hasColor = colorDegree?.trim().isNotEmpty ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: const Icon(Icons.shopping_bag_outlined, size: 28),
              ),
              if (hasColor)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: ColorDot(
                    width: 20,
                    height: 20,
                    color: parseColorDegree(colorDegree),
                    selected: false,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatPriceWithSymbol(price, symbol: '\$'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                if (optionName.trim().isNotEmpty)
                  Text(
                    optionName,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                if (packagingTitle.trim().isNotEmpty)
                  Text(
                    packagingTitle,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                Text(
                  '${'order_details.qty'.tr()}: $quantity',
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
