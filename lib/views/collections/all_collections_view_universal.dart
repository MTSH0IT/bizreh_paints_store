import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/views/collections/collection_list_view.dart';
import 'package:bizreh_paints_store/views/universal/universal_see_all_view.dart';
import 'package:bizreh_paints_store/views/universal/widgets/see_all_grid_card.dart';
import 'package:bizreh_paints_store/views/universal/widgets/see_all_list_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class AllCollectionsViewUniversal extends StatelessWidget {
  const AllCollectionsViewUniversal({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionControllers controller = Get.find<CollectionControllers>();

    return Obx(() {
      final parents = controller.collections
          .where((e) => e.parentCollectionId == null)
          .toList(growable: false);

      return UniversalSeeAllView<CollectionModel>(
        title: '${tr('home.collections')} (${parents.length})',
        items: parents,
        isLoading: controller.isLoading.value && controller.collections.isEmpty,
        emptyMessage: 'No collections found',
        onRefresh: controller.getCollections,
        itemBuilder: (context, collection, index) {
          return SeeAllGridCard(
            name: context.localizedValue(
              en: collection.title,
              ar: collection.arTitle,
              fallback: '',
            ),
            imageUrl: collection.image ?? '',
            onTap: () {
              final int? id = collection.id;
              if (id == null) return;
              Get.to(() => CollectionListView(parentId: id));
            },
          );
        },
        listItemBuilder: (context, collection, index) {
          return SeeAllListCard(
            name: context.localizedValue(
              en: collection.title,
              ar: collection.arTitle,
              fallback: '',
            ),
            imageUrl: collection.image ?? '',
            onTap: () {
              final int? id = collection.id;
              if (id == null) return;
              Get.to(() => CollectionListView(parentId: id));
            },
          );
        },
      );
    });
  }
}
