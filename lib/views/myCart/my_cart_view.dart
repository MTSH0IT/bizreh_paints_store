import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/myCart/widgets/cart_item_tile.dart';
import 'package:bizreh_paints_store/views/myCart/widgets/discount_option_tile.dart';
import 'package:bizreh_paints_store/views/myCart/widgets/price_row.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/my_cart_controller.dart';
import 'package:bizreh_paints_store/controllers/order_controller.dart';

class MyCartView extends StatelessWidget {
  MyCartView({super.key});

  final MyCartController cartController = Get.find<MyCartController>();
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Cart'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          final subtotal = cartController.subtotal();
          final shipping = cartController.shipping();
          final discountAmount = cartController.discountAmount(subtotal);
          final total = subtotal + shipping + discountAmount;
          final isEmpty = cartController.isEmpty();
          if (isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartController.cartItems[index];
                          final optionName = item.optionName;
                          final packagingTitle = item.packagingTitle;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: CartItemTile(
                              image: item.image ?? "",
                              title: item.title ?? "",
                              price: item.unitPrice,
                              quantity: item.quantity,
                              optionName: optionName,
                              packagingTitle: packagingTitle,
                              onIncrement: () {
                                cartController.incrementQuantity(index);
                              },
                              onDecrement: () {
                                if (item.quantity > 1) {
                                  cartController.decrementQuantity(index);
                                } else {
                                  // Confirm before removing the item from cart
                                  Get.defaultDialog(
                                    title: 'Remove Item',
                                    middleText:
                                        'Aremove this item from the cart?',
                                    confirm: MainButton(
                                      title: 'Remove',
                                      onPressed: () {
                                        cartController.removeFromCart(index);
                                        Get.back();
                                      },
                                    ),
                                    cancel: MainButton(
                                      title: 'Cancel',
                                      onPressed: () => Get.back(),
                                    ),
                                  );
                                }
                              },
                              onSetQuantity: (newQty) {
                                cartController.updateQuantity(index, newQty);
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      // Subtotal and shipping
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            PriceRow(
                              label: 'Items (${cartController.totalItems()})',
                              amount: subtotal,
                            ),
                            PriceRow(label: 'Shipping', amount: shipping),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Discounts
                      cartController.discounts.isEmpty
                          ? SizedBox()
                          : Row(
                              children: [
                                Text(
                                  'Available Discounts',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 12),
                      ListView.separated(
                        itemCount: cartController.discounts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final d = cartController.discounts[index];
                          return DiscountOptionTile(
                            selected:
                                cartController.selectedDiscount.value == index,
                            title: d.title,
                            subtitle: d.subtitle,
                            amount: d.type == 'percentage'
                                ? -(subtotal * d.value)
                                : d.type == 'fixed'
                                ? -d.value
                                : 0.0,
                            onTap: () =>
                                cartController.setSelectedDiscount(index),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: Colors.grey, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 8),
                    // Text(
                    //   'معلومات الاتصال',
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 16,
                    //   ),
                    // ),
                    //const SizedBox(height: 8),
                    // TextField(
                    //   keyboardType: TextInputType.phone,
                    //   decoration: const InputDecoration(
                    //     labelText: 'رقم الهاتف',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   onChanged: orderController.setPhone,
                    // ),
                    //const SizedBox(height: 12),
                    // Text(
                    //   'عنوان التوصيل',
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // Obx(() {
                    //   final address = orderController.selectedAddress.value;
                    //   return Container(
                    //     width: double.infinity,
                    //     padding: const EdgeInsets.all(12),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(color: Colors.grey.shade300),
                    //     ),
                    //     child: Text(
                    //       address?.addressLine ?? 'لا يوجد عنوان افتراضي محدد',
                    //       style: TextStyle(fontSize: 14),
                    //     ),
                    //   );
                    // }),
                    // const SizedBox(height: 12),
                    // Text(
                    //   'طريقة الدفع',
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // Obx(() {
                    //   return Row(
                    //     children: orderController.paymentMethods.map((m) {
                    //       final selected =
                    //           orderController.paymentMethod.value == m;
                    //       return Padding(
                    //         padding: const EdgeInsets.only(right: 8),
                    //         child: ChoiceChip(
                    //           label: Text(m),
                    //           selected: selected,
                    //           onSelected: (_) =>
                    //               orderController.setPaymentMethod(m),
                    //         ),
                    //       );
                    //     }).toList(),
                    //   );
                    // }),
                    const SizedBox(height: 12),
                    PriceRow(
                      label: 'Total',
                      amount: total,
                      emphasis: true,
                      color: primaryColor,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return MainButton(
                        title: orderController.isSubmitting.value
                            ? 'جاري ارسال الطلب...'
                            : 'ارسال الطلب',
                        onPressed: orderController.isSubmitting.value
                            ? null
                            : () {
                                orderController.submitOrder();
                              },
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
