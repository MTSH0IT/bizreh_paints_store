import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/brands_featured_model/brands_featured_model.dart';
import 'package:bizreh_paints_store/models/productb_model.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
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
  // hasMore سيُقرأ من controller.brandProductsPagination

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
        if (controller.isBrandProductsLoading.value &&
            controller.brandProducts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2.5),
          );
        }
        final List<ProductbModel> items = controller.brandProducts;
        if (items.isEmpty) {
          return const Center(child: Text('No products'));
        }
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: _scroll,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.78,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final p = items[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: const ImageNetwork(image: ''),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            p.title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                          child: Text(
                            p.pricePerUnit != null ? '${p.pricePerUnit}' : '',
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (controller.isBrandProductsLoading.value || _isLoadingMore)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
          ],
        );
      }),
    );
  }
}
