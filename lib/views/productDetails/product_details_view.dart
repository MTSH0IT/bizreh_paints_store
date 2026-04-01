import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/controllers/cart_controllers.dart';
import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/quantity_input_dialog.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_description_section.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_details_header.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_info_section.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_options_section.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_packaging_section.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key, required this.product});

  final ProductModel product;
  final controller = Get.put(ProductDetailsController());
  final cartController = Get.find<CartController>();
  final wishCtrl = Get.find<WishListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final isMutating = cartController.isMutating.value;

        final selectedOptionId = controller.selectedOption.value;
        final fallbackProductImage = (product.image ?? '').trim();

        String headerImage = fallbackProductImage;

        if (selectedOptionId >= 0) {
          final options = product.options ?? [];
          for (final o in options) {
            if (o.id == selectedOptionId) {
              final optionImage = (o.mainImage ?? '').trim();
              if (optionImage.isNotEmpty) {
                headerImage = optionImage;
              }
              break;
            }
          }
        }

        return Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  ProductDetailsHeader(
                    image: headerImage,
                    controller: controller,
                    wishCtrl: wishCtrl,
                  ),

                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProductInfoSection(product: product),
                                const SizedBox(height: 16),
                                //Divider(color: Colors.grey, thickness: 1),
                                //const SizedBox(height: 16),
                                ProductOptionsSection(
                                  product: product,
                                  controller: controller,
                                ),
                                const SizedBox(height: 16),
                                ProductPackagingSection(
                                  product: product,
                                  controller: controller,
                                ),
                                const SizedBox(height: 20),
                                ProductDescriptionSection(product: product),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MainButton(
                      title: tr('product_details.add_to_cart'),
                      onPressed: isMutating
                          ? null
                          : () async {
                              final quantity = await showQuantityInputDialog(
                                context,
                              );
                              if (quantity == null) return;
                              await controller.addToCart(quantity: quantity);
                            },
                    ),
                  ),
                ],
              ),
            ),
            if (isMutating)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.15),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        );
      }),
    );
  }
}
