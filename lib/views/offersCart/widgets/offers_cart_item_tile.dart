import 'package:bizreh_paints_store/models/offers_cart_model/item.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/image_network.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OffersCartItemTile extends StatelessWidget {
  const OffersCartItemTile({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final productTitle = context.localizedValue(
      en: item.product?.title,
      ar: item.product?.arTitle,
      fallback: '-',
    );
    final optionTitle = context.localizedValue(
      en: item.productOption?.name,
      ar: item.productOption?.arName,
      fallback: '-',
    );
    final colorName = context.localizedValue(
      en: item.color?.name,
      ar: item.color?.arName,
      fallback: '-',
    );
    final packagingTitle = context.localizedValue(
      en: item.packaging?.title,
      ar: item.packaging?.arTitle,
      fallback: '-',
    );
    final brandTitle = context.localizedValue(
      en: item.product?.brand?.title,
      ar: item.product?.brand?.arTitle,
      fallback: '',
    );
    final categoryTitle = context.localizedValue(
      en: item.product?.category?.title,
      ar: item.product?.category?.arTitle,
      fallback: '',
    );
    final subCategoryTitle = context.localizedValue(
      en: item.product?.subCategory?.title,
      ar: item.product?.subCategory?.arTitle,
      fallback: '',
    );
    final image = item.product?.image?.trim() ?? '';
    final hasImage = image.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: ImageNetwork(image: image),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
            Text(
              productTitle,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            _InfoRow(label: tr('offers_cart.option'), value: optionTitle),
            _InfoRow(label: tr('offers_cart.color'), value: colorName),
            _InfoRow(label: tr('offers_cart.packaging'), value: packagingTitle),
            if (brandTitle.trim().isNotEmpty)
              _InfoRow(label: tr('product_details.brand'), value: brandTitle),
            if (categoryTitle.trim().isNotEmpty)
              _InfoRow(
                label: tr('product_details.category'),
                value: categoryTitle,
              ),
            if (subCategoryTitle.trim().isNotEmpty)
              _InfoRow(
                label: tr('offers_cart.sub_category'),
                value: subCategoryTitle,
              ),
            _InfoRow(
              label: tr('offers_cart.quantity'),
              value: '${item.quantity ?? 0}',
            ),
            _InfoRow(
              label: tr('offers_cart.unit_price'),
              value: '${item.pricePerUnit ?? 0}',
            ),
            _InfoRow(
              label: tr('offers_cart.total_price'),
              value: '${item.totalPrice ?? 0}',
            ),
            _InfoRow(
              label: tr('offers_cart.stock_quantity'),
              value: '${item.stockQuantity ?? 0}',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }
}
