import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({
    super.key,
    required this.image,
    required this.controller,
    required this.wishCtrl,
  });

  final String image;
  final ProductDetailsController controller;
  final WishListController wishCtrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5 / 2,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageNetwork(image: image, icon: Icons.format_paint),
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleIconButton(icon: Icons.arrow_back, onPressed: Get.back),
                Obx(() {
                  final opid = controller.selectedPackaging.value;
                  final isFav = wishCtrl.isFavorite(opid);
                  if (wishCtrl.isAddRemoveLoading.value) {
                    return BuildProgressIndicator();
                  }
                  return CircleIconButton(
                    icon: isFav ? Icons.favorite : Icons.favorite_border,
                    onPressed: () {
                      isFav
                          ? wishCtrl.removeItem(opid)
                          : wishCtrl.addToWishList(opid);
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
