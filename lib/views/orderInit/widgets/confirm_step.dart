import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/views/orderInit/widgets/confirm_item_tile.dart';
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
                ...cart.items!.expand(
                  (item) => [
                    ConfirmItemTile(item: item),
                    if (item != cart.items!.last)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45,
                          vertical: 8,
                        ),
                        child: const Divider(height: 16),
                      ),
                  ],
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
