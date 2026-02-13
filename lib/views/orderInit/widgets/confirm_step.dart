import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
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
        final itemsCount = cart?.summary?.itemsCount ?? 0;
        final deliveryFee = cart?.summary?.deliveryFee ?? 0;
        final discountAmount = formatPrice(cart?.summary?.discountAmount ?? 0);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Confirm Order',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Address
              Text(
                'Delivery address',
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
                const Text('No delivery address selected'),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              // Cart items
              const Text(
                'Order Items',
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
                                item.product?.title ?? 'Unknown Product',
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
                                Text(
                                  'Color: ${item.packaging!.color!.degree!}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Qty: ${item.quantityPerUnit}',
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            formatPrice((item.totalPrice ?? 0).toDouble()),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                const Text(
                  'No items in cart',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              // Order summary
              const Text(
                'Order summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text('Items: $itemsCount', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Text('Subtotal: $subtotal', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Text(
                'Delivery Fee: $deliveryFee',
                style: const TextStyle(fontSize: 14),
              ),
              if (double.tryParse(discountAmount) != null &&
                  double.tryParse(discountAmount)! > 0) ...[
                const SizedBox(height: 4),
                Text(
                  'Discount: -$discountAmount',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Total: $total',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'order_init.submit_disclaimer'.tr(),
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        );
      }),
    );
  }
}
