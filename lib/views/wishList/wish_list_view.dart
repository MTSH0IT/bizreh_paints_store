import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/productDetails/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/wish_list_item.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<WishListController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'حذف كل المفضلة',
            onPressed: () {
              if (ctrl.items.isEmpty) {
                showMassage("لا يوجد منتجات في مفضلة", false);
                return;
              }
              ctrl.clearAll();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (ctrl.isGetLoading.value) {
          return const BuildProgressIndicator();
        }
        if (ctrl.items.isEmpty) {
          return const Center(child: Text('No items in wishlist'));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: ctrl.items.length,
          itemBuilder: (context, index) {
            final item = ctrl.items[index];
            return GestureDetector(
              onTap: () {
                //  Get.to(() => ProductDetailsView(product: item));
              },
              child: WishListItemCard(
                item: item,
                onMoveToCart: () {
                  ctrl.addWishlistItemToCart(item);
                },
                onRemove: () {
                  ctrl.removeItem(item.id!);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
