import 'package:bizreh_paints_store/models/cart_model/cart_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/views/myCart/widgets/cart_items_section.dart';
import 'package:bizreh_paints_store/views/myCart/widgets/cart_summary_section.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/views/orderInit/order_init_flow_view.dart';

class MyCartView extends StatelessWidget {
  MyCartView({super.key});

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('cart.title'.tr()),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (cartController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final cart = cartController.cart.value ?? CartModel();
          final items = cart.items ?? const [];

          if (items.isEmpty) {
            return Center(child: Text('cart.empty'.tr()));
          }
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: CartItemsSection(
                      items: items,
                      cartController: cartController,
                    ),
                  ),
                  CartSummarySection(
                    summary: cart.summary,
                    onCheckout: () => Get.to(() => const OrderInitFlowView()),
                  ),
                ],
              ),
              if (cartController.isMutating.value)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.15),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
