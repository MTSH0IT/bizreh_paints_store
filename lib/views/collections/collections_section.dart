import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_parent_card.dart';
import 'package:bizreh_paints_store/views/collections/collection_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class CollectionsSection extends StatelessWidget {
  const CollectionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CollectionControllers>();

    return Obx(() {
      if (ctrl.isLoading.value && ctrl.collections.isEmpty) {
        return const BuildProgressIndicator();
      }

      final parents = ctrl.collections
          .where((e) => e.parentCollectionId == null)
          .toList(growable: false);

      if (parents.isEmpty) {
        return SizedBox(
          height: 120,
          child: Center(child: Text('home.no_collections'.tr())),
        );
      }

      return SizedBox(
        height: 134,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: parents.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final CollectionModel item = parents[i];
            return GestureDetector(
              onTap: () {
                final int? id = item.id;
                if (id == null) return;
                Get.to(() => CollectionListView(parentId: id));
              },
              child: CollectionParentCard(item: item, isSelected: false),
            );
          },
        ),
      );
    });
  }
}
