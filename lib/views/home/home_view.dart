import 'package:bizreh_paints_store/controllers/wish_list_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/views/allBrands/all_brands_view.dart';
import 'package:bizreh_paints_store/views/allCategories/all_categories_view.dart';
import 'package:bizreh_paints_store/views/allProducts/all_products_view.dart';
import 'package:bizreh_paints_store/views/home/widgets/bulletin_board.dart';
import 'package:bizreh_paints_store/views/home/widgets/categories.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/home/widgets/section_header.dart';
import 'package:bizreh_paints_store/views/home/widgets/top_brands.dart';
import 'package:bizreh_paints_store/views/home/widgets/rewards_entry_card.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.find<HomeController>();
  final WishListController wishCtrl = Get.find<WishListController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'app_name'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              BulletinBoard(),
              const SizedBox(height: 12),
              RewardsEntryCard(),
              const SizedBox(height: 16),
              SectionHeader(
                title: tr('home.top_brands'),
                onSeeAll: () {
                  controller.loadBrands();
                  Get.to(() => AllBrandsView());
                },
              ),
              const SizedBox(height: 8),
              TopBrands(),
              const SizedBox(height: 16),
              SectionHeader(
                title: tr('home.categories'),
                onSeeAll: () {
                  Get.to(() => const AllCategoriesView());
                },
              ),
              const SizedBox(height: 8),
              Categories(),
              const SizedBox(height: 16),
              SectionHeader(
                title: tr('home.featured_products'),
                onSeeAll: () {
                  controller.loadProducts();
                  Get.to(() => AllProductsView());
                },
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (controller.isTopSellingLoading.value) {
                  return BuildProgressIndicator();
                }

                if (controller.topSellingProducts.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Center(child: Text(tr('home.no_products'))),
                  );
                }
                return ProductsGrid(products: controller.topSellingProducts);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
