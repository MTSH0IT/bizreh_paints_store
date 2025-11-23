import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/brands_featured_model/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandProductsView extends StatefulWidget {
  const BrandProductsView({super.key, required this.brand});
  final BrandModel brand;

  @override
  State<BrandProductsView> createState() => _BrandProductsViewState();
}

class _BrandProductsViewState extends State<BrandProductsView> {
  final HomeController controller = Get.find<HomeController>();
  final ScrollController _scroll = ScrollController();

  int _page = 1;
  final int _limit = 20;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    controller.brandProducts.clear();
    controller.loadBrandProducts(
      brandId: widget.brand.id ?? 0,
      page: _page,
      limit: _limit,
    );

    _scroll.addListener(() async {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 120) {
        final hasMore =
            controller.brandProductsPagination.value?.hasMore ?? false;
        if (!_isLoadingMore &&
            hasMore &&
            !controller.isBrandProductsLoading.value) {
          _isLoadingMore = true;
          _page += 1;
          await controller.loadBrandProducts(
            brandId: widget.brand.id ?? 0,
            page: _page,
            limit: _limit,
            append: true,
          );
          _isLoadingMore = false;
        }
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.brand.title ?? 'Brand Products',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (controller.isBrandProductsLoading.value) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2.5),
          );
        }
        final List<ProductModel> items = controller.brandProducts;
        if (items.isEmpty) {
          return const Center(child: Text('No products'));
        }
        return ProductsGrid(products: items, scrollController: _scroll);
      }),
    );
  }
}
