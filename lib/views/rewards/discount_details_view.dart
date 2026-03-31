import 'package:bizreh_paints_store/models/discont_model/brand.dart';
import 'package:bizreh_paints_store/models/discont_model/category.dart';
import 'package:bizreh_paints_store/models/discont_model/discont_model.dart';
import 'package:bizreh_paints_store/models/discont_model/product.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/views/rewards/reward_shared_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DiscountDetailsView extends StatelessWidget {
  const DiscountDetailsView({
    super.key,
    required this.offer,
  });

  final DiscontModel offer;

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: offer.title,
      ar: offer.arTitle,
      fallback: '-',
    );

    final amount = offer.amount ?? 0;
    final amountType = (offer.amountType ?? '').trim();
    final minQty = offer.minQuantity ?? 0;
    final minPurchase = (offer.minPurchaseAmount ?? '').trim();
    final expiration = formatDate(offer.expirationDate);
    final createdAt = formatDate(offer.createdAt);
    final isActive = (offer.isActive ?? 0) == 1;

    final products = offer.products ?? <Product>[];
    final brands = offer.brands ?? <Brand>[];
    final categories = offer.categories ?? <Category>[];

    return Scaffold(
      appBar: CommonAppBar(title: Text(tr('rewards.discount_details_title'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.green.withValues(alpha: 0.12)
                                : Colors.grey.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            isActive
                                ? tr('rewards.active')
                                : tr('rewards.inactive'),
                            style: TextStyle(
                              color: isActive ? Colors.green : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        RewardChipText(
                          label: tr('rewards.amount'),
                          value: amountType == 'percentage'
                              ? '$amount%'
                              : '\$$amount',
                        ),
                        if (minPurchase.isNotEmpty)
                          RewardChipText(
                            label: tr('rewards.min_purchase'),
                            value: '\$$minPurchase',
                          ),
                        if (minQty > 0)
                          RewardChipText(
                            label: tr('rewards.min_qty'),
                            value: '$minQty',
                          ),
                        if (expiration.isNotEmpty)
                          RewardChipText(
                            label: tr('rewards.expires'),
                            value: expiration,
                          ),
                        if (createdAt.isNotEmpty)
                          RewardChipText(
                            label: tr('rewards.created_at'),
                            value: createdAt,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              tr('rewards.applies_to'),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            if (products.isEmpty && brands.isEmpty && categories.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(tr('rewards.no_target_items')),
                ),
              ),
            if (products.isNotEmpty)
              _DetailsSection(
                title: tr('rewards.products'),
                children: products
                    .map(
                      (product) => _DetailsTile(
                        icon: Icons.inventory_2_outlined,
                        title: context.localizedValue(
                          en: product.title,
                          ar: product.arTitle,
                          fallback: '-',
                        ),
                      ),
                    )
                    .toList(),
              ),
            if (brands.isNotEmpty)
              _DetailsSection(
                title: tr('rewards.brands'),
                children: brands
                    .map(
                      (brand) => _DetailsTile(
                        icon: Icons.business_outlined,
                        title: context.localizedValue(
                          en: brand.title,
                          ar: brand.arTitle,
                          fallback: '-',
                        ),
                      ),
                    )
                    .toList(),
              ),
            if (categories.isNotEmpty)
              _DetailsSection(
                title: tr('rewards.categories'),
                children: categories
                    .map(
                      (category) => _DetailsTile(
                        icon: Icons.category_outlined,
                        title: context.localizedValue(
                          en: category.categoryTitle,
                          ar: category.categoryArTitle,
                          fallback: '-',
                        ),
                        subtitle: (category.categoryType ?? '').trim(),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsTile extends StatelessWidget {
  const _DetailsTile({
    required this.icon,
    required this.title,
    this.subtitle = '',
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          if (subtitle.trim().isNotEmpty)
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
        ],
      ),
    );
  }
}
