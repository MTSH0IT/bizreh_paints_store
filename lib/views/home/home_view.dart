import 'package:bizreh_paints_store/controllers/offers_cart_controller.dart';
import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/controllers/rewards_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/utils/widgets/app_skeletons.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/views/brand/all_brands_view_universal.dart';
import 'package:bizreh_paints_store/views/catogorieDetails/all_categories_view_universal.dart';
import 'package:bizreh_paints_store/views/allProducts/all_products_view.dart';
import 'package:bizreh_paints_store/views/collections/all_collections_view_universal.dart';
import 'package:bizreh_paints_store/views/collections/collections_section.dart';
import 'package:bizreh_paints_store/views/home/widgets/bulletin_board.dart';
import 'package:bizreh_paints_store/views/home/widgets/categories.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/home/widgets/section_header.dart';
import 'package:bizreh_paints_store/views/home/widgets/top_brands.dart';
import 'package:bizreh_paints_store/views/home/widgets/rewards_entry_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final rewardsCtrl = Get.find<RewardsController>();
    final offersCtrl = Get.find<OffersCartController>();
    final collectionCtrl = Get.find<CollectionControllers>();

    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'app_name'),
      body: SafeArea(
        child: AppRefreshWrapper(
          onRefresh: () async {
            await Future.wait([
              controller.loadAds(),
              controller.loadCategoryTree(),
              controller.getTopSelling(),
              controller.loadFeaturedBrands(),
              rewardsCtrl.loadAll(),
              offersCtrl.loadOffers(),
              collectionCtrl.getCollections(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const BulletinBoard(),
                const SizedBox(height: 12),
                const RewardsEntryCard(),
                const SizedBox(height: 16),
                SectionHeader(
                  title: tr('home.top_brands'),
                  onSeeAll: () {
                    controller.loadBrands();
                    Get.to(() => const AllBrandsViewUniversal());
                  },
                ),
                const SizedBox(height: 8),
                const TopBrands(),
                const SizedBox(height: 16),
                SectionHeader(
                  title: tr('home.categories'),
                  onSeeAll: () {
                    Get.to(() => const AllCategoriesViewUniversal());
                  },
                ),
                const SizedBox(height: 8),
                const Categories(),
                const SizedBox(height: 16),
                SectionHeader(
                  title: tr('home.collections'),
                  onSeeAll: () {
                    Get.to(() => const AllCollectionsViewUniversal());
                  },
                ),
                const CollectionsSection(),
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
                    return AppSkeletons.productsGrid();
                  }

                  if (controller.topSellingProducts.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(child: Text(tr('home.no_products'))),
                    );
                  }
                  return ProductsGrid(products: controller.topSellingProducts);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
