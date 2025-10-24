import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/wish_list_item.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(WishListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (ctrl.items.isEmpty) {
          return const Center(child: Text('No items in wishlist'));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: ctrl.items.length,
          itemBuilder: (context, index) {
            final item = ctrl.items[index];
            return WishListItemCard(
              imageUrl: item.image,
              title: item.title,
              subtitle: item.subTitle,
              price: '\$${item.price.toStringAsFixed(0)}',
              onMoveToCart: () {
                ctrl.addToCart(item);
              },
              onRemove: () => ctrl.toggle(item),
            );
          },
        );
      }),
    );
  }
}
