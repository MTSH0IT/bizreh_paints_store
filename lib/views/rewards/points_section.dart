import 'package:bizreh_paints_store/controllers/rewards_controller.dart';
import 'package:bizreh_paints_store/models/point_rule_model.dart';
import 'package:bizreh_paints_store/utils/func/date_format.dart';
import 'package:bizreh_paints_store/utils/func/localized_value.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/rewards/reward_shared_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class PointsRulesTab extends StatelessWidget {
  const PointsRulesTab({
    super.key,
    required this.ctrl,
  });

  final RewardsController ctrl;

  @override
  Widget build(BuildContext context) {
    return AppRefreshWrapper(
      onRefresh: ctrl.loadPointsRules,
      child: Obx(() {
        final isLoading = ctrl.isLoadingPointsRules.value;
        final rules = ctrl.pointsRules;

        if (isLoading && rules.isEmpty) {
          return const BuildProgressIndicator();
        }

        if (rules.isEmpty) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 240,
                child: Center(child: Text(tr('rewards.no_points_rules'))),
              ),
            ],
          );
        }

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: rules.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => PointsRuleCard(rule: rules[i]),
        );
      }),
    );
  }
}

class PointsRuleCard extends StatelessWidget {
  const PointsRuleCard({
    super.key,
    required this.rule,
  });

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
                RewardChipText(
                  label: tr('rewards.points_per_unit'),
                  value: '$pointsPerUnit',
                ),
                if (minQty > 0)
                  RewardChipText(label: tr('rewards.min_qty'), value: '$minQty'),
                if (start.isNotEmpty)
                  RewardChipText(label: tr('rewards.start'), value: start),
                if (end.isNotEmpty)
                  RewardChipText(label: tr('rewards.end'), value: end),
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
