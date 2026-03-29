import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_parent_card.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_path_back_button.dart';
import 'package:bizreh_paints_store/views/collections/widgets/collection_sub_collection_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class CollectionsSection extends StatefulWidget {
  const CollectionsSection({super.key});

  @override
  State<CollectionsSection> createState() => _CollectionsSectionState();
}

class _CollectionsSectionState extends State<CollectionsSection> {
  int? _selectedParentId;
  final List<int> _pathIds = <int>[];

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CollectionControllers>();

    return Obx(() {
      if (ctrl.isLoading.value && ctrl.collections.isEmpty) {
        return BuildProgressIndicator();
      }

      final parents = ctrl.collections
          .where((e) => e.parentCollectionId == null)
          .toList(growable: false);

      if (parents.isEmpty) {
        return const SizedBox.shrink();
      }

      final selectedParent = parents.cast<CollectionModel?>().firstWhere(
        (e) => e?.id == _selectedParentId,
        orElse: () => null,
      );

      final hasSelection = selectedParent != null;
      final currentNode = hasSelection
          ? _resolveCurrentNode(selectedParent)
          : null;
      final subCollections = currentNode?.subCollections ?? <CollectionModel>[];
      final products = currentNode?.products ?? const [];
      final showSubCollections = hasSelection && subCollections.isNotEmpty;
      final showProducts = hasSelection && products.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 134,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: parents.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final item = parents[i];
                final isSelected = item.id == _selectedParentId;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedParentId = isSelected ? null : item.id;
                      _pathIds.clear();
                    });
                  },
                  child: CollectionParentCard(
                    item: item,
                    isSelected: isSelected,
                  ),
                );
              },
            ),
          ),
          if (_pathIds.isNotEmpty && currentNode != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CollectionPathBackButton(
                label: context.localizedValue(
                  en: currentNode.parentTitle,
                  ar: currentNode.parentArTitle,
                  fallback: tr('common.back'),
                ),
                onTap: () {
                  setState(() {
                    _pathIds.removeLast();
                  });
                },
              ),
            ),
          ],
          const SizedBox(height: 8),
          if (showSubCollections)
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subCollections.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final child = subCollections[i];
                return CollectionSubCollectionTile(
                  item: child,
                  onTap: () {
                    final hasChildren =
                        (child.subCollections?.isNotEmpty ?? false);
                    final hasProducts = (child.products?.isNotEmpty ?? false);
                    if (!hasChildren && !hasProducts) return;
                    final id = child.id;
                    if (id == null) return;
                    setState(() {
                      _pathIds.add(id);
                    });
                  },
                );
              },
            )
          else if (showProducts)
            ProductsGrid(products: products)
          else if (!hasSelection)
            const SizedBox.shrink()
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                tr('home.no_products'),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      );
    });
  }

  CollectionModel _resolveCurrentNode(CollectionModel selectedParent) {
    CollectionModel current = selectedParent;

    for (final id in _pathIds) {
      final next = (current.subCollections ?? <CollectionModel>[])
          .cast<CollectionModel?>()
          .firstWhere((e) => e?.id == id, orElse: () => null);
      if (next == null) break;
      current = next;
    }

    return current;
  }
}
