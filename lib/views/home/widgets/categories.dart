import 'package:bizreh_paints_store/views/catogorieDetails/catogorie_ditails_view.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/home_controller.dart';
import 'package:bizreh_paints_store/models/category_tree/category_tree_model.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Obx(() {
      if (controller.isCategoryTreeLoading.value) {
        return const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      final list = controller.categoryTree;
      if (list.isEmpty) {
        return const SizedBox(
          height: 120,
          child: Center(child: Text('No categories')),
        );
      }
      return SizedBox(
        height: 120,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            final CategoryTreeModle item = list[i];
            return GestureDetector(
              onTap: () {
                Get.to(() => CatogorieDitailsView(superCategory: item));
              },
              child: _CategorieItem(item: item),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemCount: list.length,
        ),
      );
    });
  }
}

class _CategorieItem extends StatelessWidget {
  const _CategorieItem({required this.item});

  final CategoryTreeModle item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ImageNetwork(image: item.image ?? ''),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            item.title ?? '',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
