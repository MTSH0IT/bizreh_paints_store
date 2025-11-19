import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/brands_featured_model/brands_featured_model.dart';
import 'package:bizreh_paints_store/views/brand/brand_products_view.dart';

class TopBrands extends StatelessWidget {
  const TopBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return SizedBox(
      height: 110,
      child: Obx(() {
        if (controller.isBrandsFeaturedLoading.value) {
          return const BuildProgressIndicator();
        }
        final List<BrandModel> items = controller.featuredBrands;
        if (items.isEmpty) {
          return const Center(child: Text('No featured brands'));
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => BrandProductsView(brand: item));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 110,
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
                  child: ImageNetwork(image: item.image ?? ''),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemCount: items.length,
        );
      }),
    );
  }
}
