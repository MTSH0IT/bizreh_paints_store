import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/brands_featured_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/views/brand/brand_products_view.dart';
import 'package:bizreh_paints_store/views/universal/universal_see_all_view.dart';
import 'package:bizreh_paints_store/views/universal/widgets/see_all_grid_card.dart';
import 'package:bizreh_paints_store/views/universal/widgets/see_all_list_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class AllBrandsViewUniversal extends StatelessWidget {
  const AllBrandsViewUniversal({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(() {
      return UniversalSeeAllView<BrandModel>(
        title: tr('home.brands'),
        items: controller.brands,
        isLoading: controller.isBrandsLoading.value,
        emptyMessage: 'No brands found',
        itemBuilder: (context, brand, index) {
          return SeeAllGridCard(
            name: context.localizedValue(
              en: brand.title,
              ar: brand.arTitle,
              fallback: '',
            ),
            imageUrl: brand.image ?? '',
            onTap: () {
              Get.to(() => BrandProductsView(brand: brand));
            },
          );
        },
        listItemBuilder: (context, brand, index) {
          return SeeAllListCard(
            name: context.localizedValue(
              en: brand.title,
              ar: brand.arTitle,
              fallback: '',
            ),
            imageUrl: brand.image ?? '',
            onTap: () {
              Get.to(() => BrandProductsView(brand: brand));
            },
          );
        },
      );
    });
  }
}
