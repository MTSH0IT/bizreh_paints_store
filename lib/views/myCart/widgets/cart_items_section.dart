import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/models/cart_model/item.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/myCart/widgets/cart_item_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class CartItemsSection extends StatelessWidget {
  const CartItemsSection({
    super.key,
    required this.items,
    required this.cartController,
  });

  final List<Item> items;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final qty = item.quantityPerUnit ?? 1;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CartItemTile(
                  item: item,
                  onIncrement: () {
                    final cartItemId = item.id ?? 0;
                    cartController.increaseQuantity(
                      cartItemId: cartItemId,
                      quantity: 1,
                    );
                  },
                  onDecrement: () {
                    if (qty > 1) {
                      final cartItemId = item.id ?? 0;
                      cartController.decreaseQuantity(
                        cartItemId: cartItemId,
                        quantity: 1,
                      );
                    }
                  },
                  onDelete: () {
                    Get.defaultDialog(
                      title: 'cart.remove_item'.tr(),
                      middleText: 'cart.remove_item_confirm'.tr(),
                      confirm: MainButton(
                        title: 'cart.remove'.tr(),
                        onPressed: () {
                          final cartItemId = item.id ?? 0;
                          cartController.deleteCartItem(cartItemId);
                          Get.back();
                        },
                      ),
                      cancel: MainButton(
                        title: 'cart.cancel'.tr(),
                        onPressed: () => Get.back(),
                      ),
                    );
                  },
                  onSetQuantity: (newQty) {
                    final cartItemId = item.id ?? 0;
                    //final colorFamilyId = item.colorFamilyId ?? 0;
                    cartController.updateCartItem(
                      cartItemId: cartItemId,
                      quantity: newQty,
                      //colorFamilyId: colorFamilyId,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
