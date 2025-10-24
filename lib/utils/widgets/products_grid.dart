import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/product_model.dart';
import 'package:bizreh_paints_store/views/productDetails/product_details_view.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid({super.key, this.isNeverScrollable = true});
  final HomeController controller = Get.find();
  final bool isNeverScrollable;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(40.0),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.products.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(40.0),
          child: Center(child: Text('No products available')),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: GridView.builder(
          shrinkWrap: isNeverScrollable,
          physics: isNeverScrollable
              ? const NeverScrollableScrollPhysics()
              : null,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemCount: controller.products.length,
          itemBuilder: (_, i) {
            final ProductModel product = controller.products[i];
            return _ProductCard(product: product);
          },
        ),
      );
    });
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailsView(product: product));
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageNetwork(
                      image: product.image,
                      icon: Icons.format_paint,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                product.subTitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
