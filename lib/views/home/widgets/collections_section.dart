import 'package:bizreh_paints_store/controllers/collection_controllers.dart';
import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:bizreh_paints_store/utils/widgets/products_grid.dart';
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
        return const SizedBox(height: 120, child: BuildProgressIndicator());
      }

      final parents = ctrl.collections
          .where((e) => e.parentCollectionId == null)
          .toList(growable: false);

      if (parents.isEmpty) {
        return const SizedBox.shrink();
      }

      final effectiveParentId = _selectedParentId ?? (parents.first.id ?? 0);
      final selectedParent = parents.cast<CollectionModel?>().firstWhere(
        (e) => e?.id == effectiveParentId,
        orElse: () => null,
      );

      if (selectedParent == null) {
        return const SizedBox.shrink();
      }

      final currentNode = _resolveCurrentNode(selectedParent);
      final subCollections = currentNode.subCollections ?? <CollectionModel>[];
      final products = currentNode.products ?? const [];

      final showSubCollections = subCollections.isNotEmpty;
      final showProducts = products.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: parents.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, i) {
                final item = parents[i];
                final isSelected = item.id == effectiveParentId;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedParentId = item.id;
                      _pathIds.clear();
                    });
                  },
                  child: _ParentCollectionItem(
                    item: item,
                    isSelected: isSelected,
                  ),
                );
              },
            ),
          ),
          if (_pathIds.isNotEmpty) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _pathIds.removeLast();
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.chevron_left, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        context.localizedValue(
                          en: currentNode.parentTitle,
                          ar: currentNode.parentArTitle,
                          fallback: 'Back',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
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
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final child = subCollections[i];
                return _SubCollectionTile(
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
          else
            const SizedBox.shrink(),
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

class _ParentCollectionItem extends StatelessWidget {
  const _ParentCollectionItem({required this.item, required this.isSelected});

  final CollectionModel item;
  final bool isSelected;

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
              border: Border.all(
                color: isSelected ? Colors.black54 : Colors.grey.shade200,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: ImageNetwork(image: item.image ?? ''),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            context.localizedValue(
              en: item.title,
              ar: item.arTitle,
              fallback: '',
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _SubCollectionTile extends StatelessWidget {
  const _SubCollectionTile({required this.item, required this.onTap});

  final CollectionModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasChildren = (item.subCollections?.isNotEmpty ?? false);
    final hasProducts = (item.products?.isNotEmpty ?? false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 56,
                height: 56,
                child: ImageNetwork(image: item.image ?? ''),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.localizedValue(
                  en: item.title,
                  ar: item.arTitle,
                  fallback: '',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            if (hasChildren || hasProducts)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.chevron_right, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}
