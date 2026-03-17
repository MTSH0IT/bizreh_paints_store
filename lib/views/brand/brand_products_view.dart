import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class BrandProductsView extends StatefulWidget {
  const BrandProductsView({super.key, required this.brand});
  final BrandModel brand;

  @override
  State<BrandProductsView> createState() => _BrandProductsViewState();
}

class _BrandProductsViewState extends State<BrandProductsView> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.brandProducts.clear();
    controller.loadBrandProducts(brandId: widget.brand.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Text(
          context.localizedValue(
            en: widget.brand.title,
            ar: widget.brand.arTitle,
            fallback: tr('brand.products_title'),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isBrandProductsLoading.value) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2.5),
            );
          }
          final List<ProductModel> items = controller.brandProducts;
          if (items.isEmpty) {
            return Center(child: Text(tr('brand.no_products')));
          }
          return ProductsGrid(products: items, isNeverScrollable: false);
        }),
      ),
    );
  }
}
