import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'widgets/wish_list_item.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<WishListController>();

    return Scaffold(
      appBar: CommonAppBar(
        titleKey: 'wishlist.title',
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: tr('wishlist.clear_all'),
            onPressed: () {
              if (ctrl.items.isEmpty) {
                showMassage(tr('wishlist.empty_snackbar'), false);
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
          return Center(child: Text(tr('wishlist.empty')));
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
                onMoveToCart: () async {
                  await ctrl.addWishlistItemToCart(item);
                },
                onRemove: () {
                  ctrl.removeItem(item.optionPackagingId!);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
