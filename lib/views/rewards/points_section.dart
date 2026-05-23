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
  const PointsRulesTab({super.key, required this.ctrl});

  final RewardsController ctrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: AppRefreshWrapper(
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
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: RewardEmptyState(
                      message: tr('rewards.no_points_rules'),
                      icon: Icons.stars_outlined,
                    ),
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
        ),
      ),
    );
  }
}

class PointsRuleCard extends StatelessWidget {
  const PointsRuleCard({super.key, required this.rule});

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
                    Icons.stars_outlined,
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
                  label: tr('rewards.points_per_unit'),
                  value: '$pointsPerUnit',
                  icon: Icons.add_circle_outline,
                ),
                if (minQty > 0)
                  RewardChipText(
                    label: tr('rewards.min_qty'),
                    value: '$minQty',
                    icon: Icons.inventory_2_outlined,
                  ),
                if (start.isNotEmpty)
                  RewardChipText(
                    label: tr('rewards.start'),
                    value: start,
                    icon: Icons.calendar_today_outlined,
                  ),
                if (end.isNotEmpty)
                  RewardChipText(
                    label: tr('rewards.end'),
                    value: end,
                    icon: Icons.event_available_outlined,
                  ),
              ],
            ),
            if (brandTitle.isNotEmpty || packagingTitle.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              if (brandTitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business_outlined,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${tr('rewards.brand')}: ',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          brandTitle,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (packagingTitle.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.view_in_ar_outlined,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${tr('rewards.packaging')}: ',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        packagingTitle,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }
}
