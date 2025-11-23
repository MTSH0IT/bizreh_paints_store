import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/circle_icon_button.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/option.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key, required this.product});

  final ProductModel product;
  final controller = Get.put(ProductDetailsController());
  final wishCtrl = Get.find<WishListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2.5 / 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ImageNetwork(
                    image: product.image ?? "",
                    icon: Icons.format_paint,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    right: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleIconButton(
                          icon: Icons.arrow_back,
                          onPressed: Get.back,
                        ),
                        Obx(() {
                          final opid = controller.selectedOption.value;
                          final isFav = wishCtrl.isFavorite(opid);
                          if (wishCtrl.isAddRemoveLoading.value) {
                            return BuildProgressIndicator();
                          }
                          return CircleIconButton(
                            icon: isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
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
            ),

            // Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "brand : ${product.brandName}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "subCategory : ${product.subCategoryName}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(color: Colors.blueGrey, thickness: 1),
                      const SizedBox(height: 16),
                      // Options section
                      if ((product.options ?? []).isNotEmpty) ...[
                        Text(
                          'Options',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          final options = product.options!;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(options.length, (i) {
                              final option = options[i];
                              final selected =
                                  option.id == controller.selectedOption.value;

                              return Option(
                                title: option.optionName ?? '',
                                selected: selected,
                                onTap: () =>
                                    controller.selectOption(option.id!),
                              );
                            }),
                          );
                        }),
                        const SizedBox(height: 24),
                      ],

                      // Packaging section
                      if ((product.packaging ?? []).isNotEmpty) ...[
                        Text(
                          'Packaging',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          final packagingList = product.packaging!;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(packagingList.length, (i) {
                              final pkg = packagingList[i];
                              final selected =
                                  pkg.id == controller.selectedPackaging.value;
                              final title = pkg.title ?? '';
                              return Option(
                                title: title,
                                selected: selected,
                                onTap: () =>
                                    controller.selectPackaging(pkg.id!),
                              );
                            }),
                          );
                        }),
                      ],

                      const SizedBox(height: 20),
                      Text(
                        product.description ?? "",
                        style: TextStyle(
                          color: Colors.black,
                          height: 2,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom bar button
            ),
            MainButton(
              title: "Add to Cart",
              onPressed: () {
                return controller.addToCart(product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
