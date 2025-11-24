import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/utils/consts/text.dart';
import 'package:bizreh_paints_store/views/allBrands/all_brands_view.dart';
import 'package:bizreh_paints_store/views/allCategories/all_categories_view.dart';
import 'package:bizreh_paints_store/views/allProducts/all_products_view.dart';
import 'package:bizreh_paints_store/views/home/widgets/bulletin_board.dart';
import 'package:bizreh_paints_store/views/home/widgets/categories.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/home/widgets/section_header.dart';
import 'package:bizreh_paints_store/views/home/widgets/top_brands.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.find<HomeController>();
  final WishListController wishCtrl = Get.find<WishListController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(nameApp),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              BulletinBoard(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'Top Brands',
                onSeeAll: () {
                  controller.loadBrands();
                  Get.to(() => AllBrandsView());
                },
              ),
              const SizedBox(height: 8),
              TopBrands(),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'Categories',
                onSeeAll: () {
                  Get.to(() => const AllCategoriesView());
                },
              ),
              const SizedBox(height: 8),
              Categories(),
              const SizedBox(height: 16),
              SectionHeader(
                title: "Featured Products",
                onSeeAll: () {
                  Get.to(() => AllProductsView(products: controller.products));
                },
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (controller.isLoading.value) {
                  return BuildProgressIndicator();
                }

                if (controller.products.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Center(child: Text('No products available')),
                  );
                }
                return ProductsGrid(products: controller.products);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
