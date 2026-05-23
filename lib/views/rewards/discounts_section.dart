import 'package:bizreh_paints_store/controllers/rewards_controller.dart';
import 'package:bizreh_paints_store/models/discont_model/discont_model.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/rewards/discount_details_view.dart';
import 'package:bizreh_paints_store/views/rewards/reward_shared_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class DiscountsTab extends StatelessWidget {
  const DiscountsTab({super.key, required this.ctrl});

  final RewardsController ctrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: AppRefreshWrapper(
          onRefresh: ctrl.loadDiscountOffers,
          child: Obx(() {
            final isLoading = ctrl.isLoadingDiscounts.value;
            final offers = ctrl.discountOffers;

            if (isLoading && offers.isEmpty) {
              return const BuildProgressIndicator();
            }

            if (offers.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: RewardEmptyState(
                      message: tr('rewards.no_discounts'),
                      icon: Icons.local_offer_outlined,
                    ),
                  ),
                ],
              );
            }

            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: offers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => DiscountOfferCard(offer: offers[i]),
            );
          }),
        ),
      ),
    );
  }
}

class DiscountOfferCard extends StatelessWidget {
  const DiscountOfferCard({super.key, required this.offer});

  final DiscontModel offer;

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: offer.title,
      ar: offer.arTitle,
      fallback: '-',
    );

    final expiration = formatDate(offer.expirationDate);
    final minPurchase = (offer.minPurchaseAmount ?? '').trim();
    final minQty = offer.minQuantity ?? 0;
    final amount = offer.amount ?? 0;
    final amountType = (offer.amountType ?? '').trim();

    final productsCount = offer.productsCount ?? (offer.products?.length ?? 0);
    final brandsCount = offer.brandsCount ?? (offer.brands?.length ?? 0);
    final categoriesCount =
        offer.categoriesCount ?? (offer.categories?.length ?? 0);

    final isActive = (offer.isActive ?? 0) == 1;

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200, width: 1.5),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_offer_outlined,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
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
                    isActive ? tr('rewards.active') : tr('rewards.inactive'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.green : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                RewardChipText(
                  label: tr('rewards.amount'),
                  value: amountType == 'percentage' ? '$amount%' : '\$$amount',
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
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      if (productsCount > 0)
                        RewardMetaCount(
                          label: tr('rewards.products'),
                          count: productsCount,
                          icon: Icons.inventory_2_outlined,
                        ),
                      if (brandsCount > 0)
                        RewardMetaCount(
                          label: tr('rewards.brands'),
                          count: brandsCount,
                          icon: Icons.business_outlined,
                        ),
                      if (categoriesCount > 0)
                        RewardMetaCount(
                          label: tr('rewards.categories'),
                          count: categoriesCount,
                          icon: Icons.category_outlined,
                        ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () =>
                      Get.to(() => DiscountDetailsView(offer: offer)),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: Text(tr('rewards.view_details')),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
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
