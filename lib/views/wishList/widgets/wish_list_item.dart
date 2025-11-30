import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/models/wishlist_model.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/utils/func/price_format.dart';

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: ImageNetwork(image: item.mainImage ?? ""),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.optionName ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$ ${formatPrice(item.pricePerUnit ?? 0)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: onMoveToCart,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                    ),
                    child: const Text(
                      'Move to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Text("|", style: TextStyle(color: Colors.grey)),
                Expanded(
                  child: Obx(() {
                    final isRemoving =
                        cont.isAddRemoveLoading.value &&
                        cont.removingId.value == item.id;
                    return TextButton(
                      onPressed: isRemoving ? null : onRemove,
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                      ),
                      child: isRemoving
                          ? const BuildProgressIndicator()
                          : const Text(
                              'Remove',
                              style: TextStyle(
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
