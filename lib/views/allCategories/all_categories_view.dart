import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/see_all_card.dart';
import 'package:get/get.dart';

import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/catogorieDetails/catogorie_ditails_view.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.black),
        ),

        //actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          if (controller.isCategoryTreeLoading.value &&
              controller.categoryTree.isEmpty) {
            return const BuildProgressIndicator();
          }

          if (controller.categoryTree.isEmpty) {
            return const Center(child: Text('No categories'));
          }

          return GridView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 16,
              childAspectRatio: 1.25,
            ),
            itemCount: controller.categoryTree.length,
            itemBuilder: (context, index) {
              final category = controller.categoryTree[index];
              return SeeAllCard(
                name: category.title ?? '',
                imageUrl: category.image ?? '',
                onTap: () {
                  Get.to(() => CatogorieDitailsView(superCategory: category));
                },
              );
            },
          );
        }),
      ),
    );
  }
}
