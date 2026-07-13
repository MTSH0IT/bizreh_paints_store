import 'package:bizreh_paints_store/models/offers_cart_model/offers_cart_model.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/views/offersCart/widgets/offers_cart_chip_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OffersCartOfferCard extends StatelessWidget {
  const OffersCartOfferCard({
    super.key,
    required this.offer,
    required this.isPurchasing,
    required this.onPurchase,
    required this.onViewDetails,
  });

  final OffersCartModel offer;
  final bool isPurchasing;
  final VoidCallback onPurchase;
  final VoidCallback onViewDetails;

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

    final qty = offer.quantity ?? 0;
    final itemsCount = offer.itemsCount ?? 0;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_offer_outlined, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
            if (desc.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                desc,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                OffersCartChipText(
                  label: tr('offers_cart.price'),
                  value: offer.price?.toString() ?? '-',
                ),
                OffersCartChipText(
                  label: tr('offers_cart.quantity'),
                  value: '$qty',
                ),
                OffersCartChipText(
                  label: tr('offers_cart.items_count'),
                  value: '$itemsCount',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onViewDetails,
                    child: Text(tr('offers_cart.view_details')),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isPurchasing ? null : onPurchase,
                    child: Text(
                      isPurchasing
                          ? tr('offers_cart.purchasing')
                          : tr('offers_cart.purchase'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
