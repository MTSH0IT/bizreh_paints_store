import 'package:bizreh_paints_store/models/offers_cart_model/offers_cart_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/views/offersCart/widgets/offers_cart_chip_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OffersCartOfferDetailsCard extends StatelessWidget {
  const OffersCartOfferDetailsCard({super.key, required this.offer});

  final OffersCartModel offer;

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: offer.name,
      ar: offer.arName,
      fallback: '-',
    );
    final desc = context.localizedValue(
      en: offer.description,
      ar: offer.arDescription,
      fallback: '',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                if ((offer.isActive ?? 0) == 1)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tr('offers_cart.active'),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            if (desc.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(desc, style: const TextStyle(color: Colors.black54)),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OffersCartChipText(
                  label: tr('offers_cart.price'),
                  value: offer.price?.toString() ?? '-',
                ),
                OffersCartChipText(
                  label: tr('offers_cart.quantity'),
                  value: '${offer.quantity ?? 0}',
                ),
                OffersCartChipText(
                  label: tr('offers_cart.items_count'),
                  value: '${offer.itemsCount ?? 0}',
                ),
                OffersCartChipText(
                  label: tr('offers_cart.total'),
                  value: '${offer.calculatedTotal ?? 0}',
                ),
                OffersCartChipText(
                  label: tr('offers_cart.savings'),
                  value: '${offer.savings ?? 0}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
