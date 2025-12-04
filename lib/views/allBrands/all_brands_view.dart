import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/brand/brand_products_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/brands_featured_model/brands_featured_model.dart';
import '../../utils/widgets/see_all_card.dart';

class AllBrandsView extends StatelessWidget {
  const AllBrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('All Brands', style: TextStyle(color: Colors.black)),

        //actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          if (controller.isBrandsLoading.value) {
            return const BuildProgressIndicator();
          }
          final List<BrandModel> items = controller.brands;
          if (items.isEmpty) {
            return const Center(child: Text('No brands'));
          }
          return GridView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 16,
              childAspectRatio: 1.25,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return SeeAllCard(
                name: item.title ?? '',
                imageUrl: item.image ?? '',
                onTap: () {
                  Get.to(() => BrandProductsView(brand: item));
                },
              );
            },
          );
        }),
      ),
    );
  }
}
