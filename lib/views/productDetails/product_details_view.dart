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
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  /// Resolves the header image based on the currently selected option.
  String _resolveHeaderImage(int selectedOptionId) {
    final fallback = (product.image ?? '').trim();
    if (selectedOptionId < 0) return fallback;
    for (final o in product.options ?? []) {
      if (o.id == selectedOptionId) {
        final optionImage = (o.mainImage ?? '').trim();
        return optionImage.isNotEmpty ? optionImage : fallback;
      }
    }
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();
    final cartController = Get.find<CartController>();
    final wishCtrl = Get.find<WishListController>();

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    // Header image reacts only to selectedOption changes
                    Obx(
                      () => ProductDetailsHeader(
                        image: _resolveHeaderImage(
                          controller.selectedOption.value,
                        ),
                        controller: controller,
                        wishCtrl: wishCtrl,
                      ),
                    ),

                    // Static content — no Obx needed here
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

                    // Button reacts only to isMutating changes
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(
                        () => MainButton(
                          title: tr('product_details.add_to_cart'),
                          onPressed: cartController.isMutating.value
                              ? null
                              : () async {
                                  final quantity =
                                      await showQuantityInputDialog(context);
                                  if (quantity == null) return;
                                  await controller.addToCart(
                                    quantity: quantity,
                                  );
                                },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Loading overlay reacts only to isMutating changes
          Obx(
            () => cartController.isMutating.value
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.15),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
