import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/product_model/product_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
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
    return Obx(() {
      final bool isLoading = controller.isBrandProductsLoading.value;
      final List<ProductModel> items = controller.brandProducts;
      final List<_BrandSubCategoryTab> tabs = _buildTabs(items);
      final bool hasProducts = items.isNotEmpty;

      return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: CommonAppBar(
            title: Text(
              context.localizedValue(
                en: widget.brand.title,
                ar: widget.brand.arTitle,
                fallback: tr('brand.products_title'),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: TabBar(
                isScrollable: true,
                labelColor: primaryColor,
                unselectedLabelColor: Colors.grey[700],
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                indicatorColor: primaryColor,
                indicatorWeight: 2.0,
                tabs: tabs
                    .map(
                      (tab) => Tab(
                        text: context.localizedValue(
                          en: tab.title,
                          ar: tab.arTitle,
                          fallback: 'Sub Category ${tab.id.toString()}',
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: isLoading
                    ? const BuildProgressIndicator()
                    : hasProducts
                    ? TabBarView(
                        children: List.generate(tabs.length, (index) {
                          final int? tabId = tabs[index].id;
                          final List<ProductModel> products = tabId == null
                              ? items
                              : items
                                    .where((p) => p.subCategoryId == tabId)
                                    .toList();
                          return ProductsGrid(
                            products: products,
                            isNeverScrollable: false,
                          );
                        }),
                      )
                    : Center(child: Text(tr('brand.no_products'))),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<_BrandSubCategoryTab> _buildTabs(List<ProductModel> items) {
    final List<_BrandSubCategoryTab> tabs = [
      const _BrandSubCategoryTab(id: null, title: 'All', arTitle: 'الجميع'),
    ];
    final Set<int> seen = <int>{};

    for (final ProductModel product in items) {
      final int? subCategoryId = product.subCategoryId;
      if (subCategoryId == null || seen.contains(subCategoryId)) {
        continue;
      }
      seen.add(subCategoryId);

      tabs.add(
        _BrandSubCategoryTab(
          id: subCategoryId,
          title: product.subCategoryName ?? 'Sub Category $subCategoryId',
          arTitle: product.arSubCategoryName ?? 'فئة فرعية $subCategoryId',
        ),
      );
    }

    return tabs;
  }
}

class _BrandSubCategoryTab {
  const _BrandSubCategoryTab({
    required this.id,
    required this.title,
    required this.arTitle,
  });

  final int? id;
  final String title;
  final String arTitle;
}
