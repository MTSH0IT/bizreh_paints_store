import 'package:bizreh_paints_store/models/collection_model/collection_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:flutter/material.dart';

class CollectionParentCard extends StatelessWidget {
  const CollectionParentCard({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final CollectionModel item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: 102,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.indigoAccent.withValues(alpha: 0.03)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected
              ? Colors.indigoAccent.withValues(alpha: 0.40)
              : Colors.black.withValues(alpha: 0.08),
          width: isSelected ? 1.4 : 1,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 86,
              height: 86,
              child: ColoredBox(
                color: Colors.white,
                child: ImageNetwork(image: item.image ?? ''),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.localizedValue(
              en: item.title,
              ar: item.arTitle,
              fallback: '',
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
