import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        final cart = orderController.cartController;
        final subtotal = cart.subtotal();
        final total = subtotal + 0;
        final itemsCount = cart.totalItems();
        final paymentMethod = orderController.paymentMethod.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm Order',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Contact info
            Text(
              'Phone number',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              orderController.phoneNumber.value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

            // Order summary
            const Text(
              'Order summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text('Items: $itemsCount', style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              'Subtotal: ${subtotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 8),
            Text(
              'Total: ${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            // Payment method
            Text(
              'Payment method',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              paymentMethod.capitalizeFirst ?? paymentMethod,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 24),
            Text(
              'By pressing "Submit order", your order will be sent using the details above.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        );
      }),
    );
  }
}
