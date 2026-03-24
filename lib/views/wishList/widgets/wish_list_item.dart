import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/models/wishlist_model/wishlist_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:bizreh_paints_store/utils/func/color_degree.dart';

class WishListItemCard extends StatelessWidget {
  final WishlistModel item;
  final VoidCallback onMoveToCart;
  final VoidCallback onRemove;

  const WishListItemCard({
    super.key,
    required this.item,
    required this.onMoveToCart,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cont = Get.find<WishListController>();

    final image = item.productOption?.mainImage ?? item.product?.image ?? "";
    final title = context.localizedValue(
      en: item.product?.title,
      ar: item.product?.arTitle,
      fallback: '',
    );
    final optionName = context.localizedValue(
      en: item.productOption?.optionName,
      ar: item.productOption?.arOptionName,
      fallback: '',
    );
    final packagingTitle = context.localizedValue(
      en: item.optionPackaging?.packaging?.title,
      ar: item.optionPackaging?.packaging?.arTitle,
      fallback: '',
    );
    final sku = item.productOption?.optionSku ?? "";
    final pricePerUnit = item.optionPackaging?.pricePerUnit ?? 0;
    final colorDegree = item.optionPackaging?.color?.degree;

    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ImageNetwork(image: image),
                      ),
                    ),
                    if (colorDegree != null)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: ColorDot(
                          color: parseColorDegree(colorDegree),
                          selected: false,
                          width: 14,
                          height: 14,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        optionName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (sku.trim().isNotEmpty) Text(sku),
                      Text(
                        packagingTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        formatPriceWithSymbol(pricePerUnit, symbol: '\$ '),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    final isMoving =
                        cont.movingToCartId.value == item.optionPackagingId;
                    return TextButton(
                      onPressed: isMoving ? null : onMoveToCart,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black87,
                      ),
                      child: isMoving
                          ? const BuildProgressIndicator()
                          : Text(
                              tr('wishlist.move_to_cart'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  }),
                ),
                Text("|", style: TextStyle(color: Colors.grey)),
                Expanded(
                  child: Obx(() {
                    final isRemoving =
                        cont.isAddRemoveLoading.value &&
                        cont.removingId.value == item.wishlistId;
                    return TextButton(
                      onPressed: isRemoving ? null : onRemove,
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                      ),
                      child: isRemoving
                          ? const BuildProgressIndicator()
                          : Text(
                              tr('wishlist.remove'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
