import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:bizreh_paints_store/controllers/order_controller.dart';

class ConfirmStep extends StatelessWidget {
  final OrderController orderController;

  const ConfirmStep({super.key, required this.orderController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        final address = orderController.selectedAddress.value;
        final cart = orderController.cartController.cart.value;
        final subtotal = formatPrice(cart?.summary?.subtotal ?? 0);
        final total = formatPrice(cart?.summary?.totalAmount ?? 0);
        final itemsCount = cart?.summary?.totalItems ?? 0;
        final deliveryFee = cart?.summary?.deliveryFee ?? 0;
        final discountAmount = formatPrice(cart?.summary?.discountAmount ?? 0);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('order_init.confirm_order'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Address
              Text(
                tr('order_init.delivery_address'),
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 4),
              if (address != null)
                Text(
                  '${address.cityName ?? ''} - ${address.addressLine ?? ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else
                Text(tr('order_init.no_delivery_address_selected')),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              // Cart items
              Text(
                tr('order_init.order_items'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              if (cart?.items != null && cart!.items!.isNotEmpty) ...[
                ...cart.items!.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product?.title ??
                                    tr('order_init.unknown_product'),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (item.option?.optionName != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  item.option!.optionName!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                              if (item.packaging?.color?.degree != null) ...[
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      '${tr('order_init.color')}: ${item.packaging!.color!.degree!}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    ColorDot(
                                      color: parseColorDegree(
                                        item.packaging!.color!.degree!,
                                      ),
                                      selected: false,
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${tr('order_init.qty')}: ${item.quantityPerUnit}',
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Builder(
                            builder: (context) {
                              final totalPrice = (item.totalPrice ?? 0)
                                  .toDouble();

                              final discount =
                                  double.tryParse(item.discountAmount ?? '0') ??
                                  0;
                              final finalPrice =
                                  double.tryParse(item.finalItemPrice ?? '') ??
                                  0;
                              final hasDiscount = discount > 0;
                              final hasFinal = finalPrice > 0;

                              return Column(
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
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.green,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  if (hasFinal)
                                    Text(
                                      formatPrice(finalPrice),
                                      style: const TextStyle(fontSize: 11),
                                      textAlign: TextAlign.right,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  tr('order_init.no_items_in_cart'),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              // Order summary
              Text(
                tr('order_init.order_summary'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                '${tr('order_init.items')}: $itemsCount',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '${tr('order_init.subtotal')}: $subtotal',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '${tr('order_init.delivery_fee')}: $deliveryFee',
                style: const TextStyle(fontSize: 14),
              ),
              if (double.tryParse(discountAmount) != null &&
                  double.tryParse(discountAmount)! > 0) ...[
                const SizedBox(height: 4),
                Text(
                  '${tr('order_init.discount')}: -$discountAmount',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                '${tr('order_init.total')}: $total',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),
              Text(
                tr('order_init.submit_disclaimer'),
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        );
      }),
    );
  }
}
