import 'package:bizreh_paints_store/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/circle_icon_button.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/color_dot.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/sheen_option.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key, required this.product});

  final ItemModel product;
  final controller = Get.put(ProductDetailsController());
  final wishCtrl = Get.put(WishListController());

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
                    image: product.mainImage ?? "",
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
                          final isFav = wishCtrl.isFavorite(product.id!);
                          return CircleIconButton(
                            icon: isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
                            onPressed: () {
                              isFav
                                  ? wishCtrl.removeItem(product.id!)
                                  : wishCtrl.addToWishList(product.id!);
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Color section
                    Text(
                      'Color',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Wrap(
                        spacing: 24,
                        runSpacing: 14,
                        children: List.generate(controller.colors.length, (i) {
                          final selected = i == controller.selectedColor.value;
                          return GestureDetector(
                            onTap: () => controller.selectColor(i),
                            child: ColorDot(
                              color: controller.colors[i],
                              selected: selected,
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Sheen',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Row(
                        children: [
                          SheenOption(
                            title: 'Matte',
                            selected: controller.selectedSheen.value == 'Matte',
                            onTap: () => controller.selectSheen('Matte'),
                          ),
                          const SizedBox(width: 12),
                          SheenOption(
                            title: 'Satin',
                            selected: controller.selectedSheen.value == 'Satin',
                            onTap: () => controller.selectSheen('Satin'),
                          ),
                          const SizedBox(width: 12),
                          SheenOption(
                            title: 'Gloss',
                            selected: controller.selectedSheen.value == 'Gloss',
                            onTap: () => controller.selectSheen('Gloss'),
                          ),
                        ],
                      ),
                    ),

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
            MainButton(
              onPressed: () {
                //return controller.addToCart(product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
