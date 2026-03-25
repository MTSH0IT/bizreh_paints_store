import 'package:bizreh_paints_store/controllers/rewards_controller.dart';
import 'package:bizreh_paints_store/controllers/offers_cart_controller.dart';
import 'package:bizreh_paints_store/views/rewards/rewards_view.dart';
import 'package:bizreh_paints_store/views/offersCart/offers_cart_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class RewardsEntryCard extends StatelessWidget {
  const RewardsEntryCard({
    super.key,
    required this.offersCtrl,
    required this.rewardsCtrl,
  });
  final RewardsController rewardsCtrl;
  final OffersCartController offersCtrl;
  @override
  Widget build(BuildContext context) {
    if (rewardsCtrl.discountOffers.isEmpty &&
        rewardsCtrl.pointsRules.isEmpty &&
        !rewardsCtrl.isLoadingDiscounts.value &&
        !rewardsCtrl.isLoadingPointsRules.value &&
        rewardsCtrl.discountsError.value.trim().isEmpty &&
        rewardsCtrl.pointsRulesError.value.trim().isEmpty) {
      rewardsCtrl.loadAll();
    }

    if (offersCtrl.offers.isEmpty &&
        !offersCtrl.isLoadingOffers.value &&
        offersCtrl.offersError.value.trim().isEmpty) {
      offersCtrl.loadOffers();
    }

    return Obx(() {
      final showDiscounts = rewardsCtrl.discountOffers.isNotEmpty;
      final showPointsRules = rewardsCtrl.pointsRules.isNotEmpty;
      final showOffersCart = offersCtrl.offers.isNotEmpty;

      if (!showDiscounts && !showPointsRules && !showOffersCart) {
        return const SizedBox.shrink();
      }

      final entries = <Widget>[];
      if (showDiscounts) {
        entries.add(
          _EntryCard(
            icon: Icons.local_offer_outlined,
            title: tr('rewards.discounts_tab'),
            subtitle: tr('rewards.discount_hint'),
            onTap: () => Get.to(() => const DiscountOffersView()),
          ),
        );
      }
      if (showPointsRules) {
        entries.add(
          _EntryCard(
            icon: Icons.stars_outlined,
            title: tr('rewards.points_tab'),
            subtitle: tr('rewards.point_hint'),
            onTap: () => Get.to(() => const PointsRulesView()),
          ),
        );
      }

      if (showOffersCart) {
        entries.add(
          _EntryCard(
            icon: Icons.shopping_cart_outlined,
            title: tr('offers_cart.title'),
            subtitle: tr('offers_cart.hint'),
            onTap: () => Get.to(() => const OffersCartView()),
          ),
        );
      }

      return SizedBox(
        height: 92,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) => entries[i],
        ),
      );
    });
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
