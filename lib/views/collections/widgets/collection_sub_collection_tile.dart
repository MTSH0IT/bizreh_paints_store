import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CollectionSubCollectionTile extends StatelessWidget {
  const CollectionSubCollectionTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final CollectionModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasChildren = (item.subCollections?.isNotEmpty ?? false);
    final hasProducts = (item.products?.isNotEmpty ?? false);
    final childrenCount = item.subCollections?.length ?? 0;
    final productsCount = item.products?.length ?? 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 58,
                height: 58,
                child: ColoredBox(
                  color: Colors.grey.shade100,
                  child: ImageNetwork(image: item.image ?? ''),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localizedValue(
                      en: item.title,
                      ar: item.arTitle,
                      fallback: '',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _metaLine(
                      context: context,
                      hasChildren: hasChildren,
                      hasProducts: hasProducts,
                      childrenCount: childrenCount,
                      productsCount: productsCount,
                    ),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: (hasChildren || hasProducts)
                    ? Colors.indigoAccent.withValues(alpha: 0.10)
                    : Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.chevron_right_rounded,
                color: (hasChildren || hasProducts)
                    ? Colors.indigoAccent.shade700
                    : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _metaLine({
    required BuildContext context,
    required bool hasChildren,
    required bool hasProducts,
    required int childrenCount,
    required int productsCount,
  }) {
    if (hasChildren && hasProducts) {
      return tr(
        'collections.categories_products_count',
        args: [childrenCount.toString(), productsCount.toString()],
      );
    }

    if (hasChildren) {
      return tr(
        'collections.categories_count',
        args: [childrenCount.toString()],
      );
    }

    if (hasProducts) {
      return tr('collections.products_count', args: [productsCount.toString()]);
    }

    return tr('collections.no_items');
  }
}
