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
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/rewards_controller.dart';

class DiscountDetailsView extends StatelessWidget {
  const DiscountDetailsView({super.key, required this.offer});

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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200, width: 1.5),
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                          icon: Icons.payments_outlined,
                        ),
                        if (minPurchase.isNotEmpty)
                          RewardChipText(
                            label: tr('rewards.min_purchase'),
                            value: '\$$minPurchase',
                            icon: Icons.shopping_cart_outlined,
                          ),
                        if (minQty > 0)
                          RewardChipText(
                            label: tr('rewards.min_qty'),
                            value: '$minQty',
                            icon: Icons.inventory_2_outlined,
                          ),
                        if (expiration.isNotEmpty)
                          RewardChipText(
                            label: tr('rewards.expires'),
                            value: expiration,
                            icon: Icons.timer_outlined,
                          ),
                        if (createdAt.isNotEmpty)
                          RewardChipText(
                            label: tr('rewards.created_at'),
                            value: createdAt,
                            icon: Icons.calendar_today_outlined,
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
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            if (products.isEmpty && brands.isEmpty && categories.isEmpty)
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200, width: 1.5),
                ),
                margin: EdgeInsets.zero,
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
                        onTap: () {
                          if (product.id == null) return;
                          Get.find<RewardsController>()
                              .navigateToProductDetails(product.id!);
                        },
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
                        // subtitle: (category.categoryType ?? '').trim(),
                      ),
                    )
                    .toList(),
              ),
          ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1.5),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: onTap != null ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (subtitle.trim().isNotEmpty) ...[
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  const SizedBox(width: 8),
                ],
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
