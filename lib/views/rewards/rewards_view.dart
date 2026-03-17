import 'package:bizreh_paints_store/controllers/rewards_controller.dart';
import 'package:bizreh_paints_store/models/discont_model/discont_model.dart';
import 'package:bizreh_paints_store/models/point_rule_model.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<RewardsController>();

    if (ctrl.discountOffers.isEmpty &&
        ctrl.pointsRules.isEmpty &&
        !ctrl.isLoadingDiscounts.value &&
        !ctrl.isLoadingPointsRules.value) {
      ctrl.loadAll();
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CommonAppBar(
          titleKey: 'rewards.title',
          actions: [
            IconButton(
              onPressed: () => ctrl.loadAll(),
              icon: const Icon(Icons.refresh),
              tooltip: tr('rewards.refresh'),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: tr('rewards.discounts_tab')),
              Tab(text: tr('rewards.points_tab')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _DiscountsTab(ctrl: ctrl),
            _PointsRulesTab(ctrl: ctrl),
          ],
        ),
      ),
    );
  }
}

class DiscountOffersView extends StatelessWidget {
  const DiscountOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<RewardsController>();

    if (ctrl.discountOffers.isEmpty &&
        !ctrl.isLoadingDiscounts.value &&
        ctrl.discountsError.value.trim().isEmpty) {
      ctrl.loadDiscountOffers();
    }

    return Scaffold(
      appBar: CommonAppBar(
        title: Text(tr('rewards.discounts_tab')),
        actions: [
          IconButton(
            onPressed: () => ctrl.loadDiscountOffers(),
            icon: const Icon(Icons.refresh),
            tooltip: tr('rewards.refresh'),
          ),
        ],
      ),
      body: _DiscountsTab(ctrl: ctrl),
    );
  }
}

class PointsRulesView extends StatelessWidget {
  const PointsRulesView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<RewardsController>();

    if (ctrl.pointsRules.isEmpty &&
        !ctrl.isLoadingPointsRules.value &&
        ctrl.pointsRulesError.value.trim().isEmpty) {
      ctrl.loadPointsRules();
    }

    return Scaffold(
      appBar: CommonAppBar(
        title: Text(tr('rewards.points_tab')),
        actions: [
          IconButton(
            onPressed: () => ctrl.loadPointsRules(),
            icon: const Icon(Icons.refresh),
            tooltip: tr('rewards.refresh'),
          ),
        ],
      ),
      body: _PointsRulesTab(ctrl: ctrl),
    );
  }
}

class _DiscountsTab extends StatelessWidget {
  const _DiscountsTab({required this.ctrl});

  final RewardsController ctrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = ctrl.isLoadingDiscounts.value;
      final err = ctrl.discountsError.value.trim();
      final offers = ctrl.discountOffers;

      if (isLoading && offers.isEmpty) {
        return const BuildProgressIndicator();
      }

      if (err.isNotEmpty && offers.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(err, textAlign: TextAlign.center),
          ),
        );
      }

      if (offers.isEmpty) {
        return Center(child: Text(tr('rewards.no_discounts')));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => _DiscountOfferCard(offer: offers[i]),
      );
    });
  }
}

class _DiscountOfferCard extends StatelessWidget {
  const _DiscountOfferCard({required this.offer});

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
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
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
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _ChipText(
                  label: tr('rewards.amount'),
                  value: amountType == 'percentage' ? '$amount%' : '\$$amount',
                ),
                if (minPurchase.isNotEmpty)
                  _ChipText(
                    label: tr('rewards.min_purchase'),
                    value: '\$$minPurchase',
                  ),
                if (minQty > 0)
                  _ChipText(label: tr('rewards.min_qty'), value: '$minQty'),
                if (expiration.isNotEmpty)
                  _ChipText(label: tr('rewards.expires'), value: expiration),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                if (productsCount > 0)
                  _MetaCount(
                    label: tr('rewards.products'),
                    count: productsCount,
                  ),
                if (brandsCount > 0) ...[
                  const SizedBox(width: 10),
                  _MetaCount(label: tr('rewards.brands'), count: brandsCount),
                ],
                if (categoriesCount > 0) ...[
                  const SizedBox(width: 10),
                  _MetaCount(
                    label: tr('rewards.categories'),
                    count: categoriesCount,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PointsRulesTab extends StatelessWidget {
  const _PointsRulesTab({required this.ctrl});

  final RewardsController ctrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = ctrl.isLoadingPointsRules.value;
      final err = ctrl.pointsRulesError.value.trim();
      final rules = ctrl.pointsRules;

      if (isLoading && rules.isEmpty) {
        return const BuildProgressIndicator();
      }

      if (err.isNotEmpty && rules.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(err, textAlign: TextAlign.center),
          ),
        );
      }

      if (rules.isEmpty) {
        return Center(child: Text(tr('rewards.no_points_rules')));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: rules.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => _PointsRuleCard(rule: rules[i]),
      );
    });
  }
}

class _PointsRuleCard extends StatelessWidget {
  const _PointsRuleCard({required this.rule});

  final PointRuleModel rule;

  @override
  Widget build(BuildContext context) {
    final title = context.localizedValue(
      en: rule.title,
      ar: rule.arTitle,
      fallback: '-',
    );

    final isActive = (rule.isActive ?? 0) == 1;
    final pointsPerUnit = rule.pointsPerUnit ?? 0;
    final minQty = rule.minQuantity ?? 0;

    final start = formatDate(rule.startDate);
    final end = formatDate(rule.endDate);

    final brandTitle = context.localizedValue(
      en: rule.brandTitle,
      ar: rule.brandArTitle,
      fallback: '',
    );

    final packagingTitle = context.localizedValue(
      en: rule.packagingTitle,
      ar: rule.packagingArTitle,
      fallback: '',
    );

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.stars_outlined, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
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
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                _ChipText(
                  label: tr('rewards.points_per_unit'),
                  value: '$pointsPerUnit',
                ),
                if (minQty > 0)
                  _ChipText(label: tr('rewards.min_qty'), value: '$minQty'),
                if (start.isNotEmpty)
                  _ChipText(label: tr('rewards.start'), value: start),
                if (end.isNotEmpty)
                  _ChipText(label: tr('rewards.end'), value: end),
              ],
            ),
            const SizedBox(height: 10),
            if (brandTitle.isNotEmpty)
              Text(
                '${tr('rewards.brand')}: $brandTitle',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            if (packagingTitle.isNotEmpty)
              Text(
                '${tr('rewards.packaging')}: $packagingTitle',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
          ],
        ),
      ),
    );
  }
}

class _MetaCount extends StatelessWidget {
  const _MetaCount({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $count',
      style: const TextStyle(fontSize: 12, color: Colors.black54),
    );
  }
}

class _ChipText extends StatelessWidget {
  const _ChipText({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
