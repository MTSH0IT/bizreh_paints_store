import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/views/catogorieDetails/catogorie_ditails_view.dart';
import 'package:bizreh_paints_store/views/universal/universal_see_all_view.dart';
import 'package:bizreh_paints_store/views/universal/widgets/see_all_grid_card.dart';
import 'package:bizreh_paints_store/views/universal/widgets/see_all_list_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class AllCategoriesViewUniversal extends StatelessWidget {
  const AllCategoriesViewUniversal({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Obx(() {
      return UniversalSeeAllView(
        title: tr('home.categories'),
        items: controller.categoryTree,
        isLoading:
            controller.isCategoryTreeLoading.value &&
            controller.categoryTree.isEmpty,
        emptyMessage: tr('home.no_categories_found'),
        itemBuilder: (context, category, index) {
          return SeeAllGridCard(
            name: context.localizedValue(
              en: category.title,
              ar: category.arTitle,
              fallback: '',
            ),
            imageUrl: category.image ?? '',
            onTap: () {
              Get.to(() => CatogorieDitailsView(superCategory: category));
            },
          );
        },
        listItemBuilder: (context, category, index) {
          return SeeAllListCard(
            name: context.localizedValue(
              en: category.title,
              ar: category.arTitle,
              fallback: '',
            ),
            imageUrl: category.image ?? '',
            onTap: () {
              Get.to(() => CatogorieDitailsView(superCategory: category));
            },
          );
        },
      );
    });
  }
}
