import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/product_details_controller.dart';
import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_description_section.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_details_header.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_info_section.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_options_section.dart';
import 'package:bizreh_paints_store/views/productDetails/widgets/product_packaging_section.dart';

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
            ProductDetailsHeader(
              image: product.image ?? "",
              controller: controller,
              wishCtrl: wishCtrl,
            ),

            // Content
            Expanded(
              child: Card(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductInfoSection(product: product),
                      const SizedBox(height: 16),
                      Divider(color: Colors.grey, thickness: 1),
                      const SizedBox(height: 16),
                      ProductOptionsSection(
                        product: product,
                        controller: controller,
                      ),
                      const SizedBox(height: 24),
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
