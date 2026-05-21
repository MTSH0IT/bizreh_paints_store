import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/views/productDetails/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:get/get.dart' hide Trans;

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    this.isNeverScrollable = true,
    required this.products,
    // this.scrollController,
  });
  final bool isNeverScrollable;
  final List<ProductModel> products;
  //inal ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        // controller: scrollController,
        shrinkWrap: isNeverScrollable,
        physics: isNeverScrollable
            ? const NeverScrollableScrollPhysics()
            : null,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: products.length,
        itemBuilder: (_, i) {
          final ProductModel product = products[i];
          return _ProductCard(product: product);
        },
      ),
    );
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
                      image: product.image ?? '',
                      icon: Icons.format_paint,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.localizedValue(
                  en: product.title,
                  ar: product.arTitle,
                  fallback: '',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                context.localizedValue(
                  en: product.brandName,
                  ar: product.arBrandName,
                  fallback: '',
                ),
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(height: 8),
              Text(
                context.localizedValue(
                  en: product.subCategoryName,
                  ar: product.arSubCategoryName,
                  fallback: '',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
