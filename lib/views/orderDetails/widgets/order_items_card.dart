import 'package:bizreh_paints_store/models/order_model/item.dart';
import 'package:bizreh_paints_store/models/order_model/order_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
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
              tr('order_details.items_ordered'),
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

  double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: item.title,
      ar: item.arTitle,
      fallback: '',
    );
    final quantity = item.quantityPerUnit ?? 0;
    final totalPrice = _toDouble(item.totalPrice);
    final unitPrice = _toDouble(item.unitPrice);
    final discountAmount = _toDouble(item.discountAmount);
    final finalItemPrice = _toDouble(item.finalItemPrice);
    final discountName = (item.appliedDiscountName ?? '').trim();
    final optionName = context.localizedValue(
      en: item.optionName,
      ar: item.arOptionName,
      fallback: '',
    );
    final packagingTitle = context.localizedValue(
      en: item.packagingTitle,
      ar: item.packagingArTitle,
      fallback: '',
    );
    final sku = item.productSku ?? "";
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
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ImageNetwork(
                    image: item.image ?? "",
                    icon: Icons.shopping_bag_outlined,
                  ),
                ),
              ),
              if (hasColor)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ColorDot(
                      width: 20,
                      height: 20,
                      color: parseColorDegree(colorDegree),
                      selected: false,
                    ),
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
                    // const SizedBox(width: 8),
                    // Text(
                    //   formatPriceWithSymbol(totalPrice, symbol: '\$'),
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 16,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 4),
                if (optionName.trim().isNotEmpty)
                  Text(
                    '${tr('order_details.option')}: $optionName',
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                if (packagingTitle.trim().isNotEmpty)
                  Text(
                    '${tr('order_details.packaging')}: $packagingTitle',
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                if (sku.trim().isNotEmpty) Text("sku: $sku"),
                Text(
                  '${tr('order_details.qty')}: $quantity',
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('order_details.unit_price'),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      formatPriceWithSymbol(totalPrice, symbol: '\$'),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                if (discountAmount > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          discountName.isEmpty
                              ? tr('order_details.discount')
                              : '${tr('order_details.discount')}: $discountName',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        '- ${formatPriceWithSymbol(discountAmount, symbol: '\$')}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('order_details.final_price'),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      formatPriceWithSymbol(finalItemPrice, symbol: '\$'),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
