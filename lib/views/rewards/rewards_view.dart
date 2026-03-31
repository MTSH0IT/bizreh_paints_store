import 'package:bizreh_paints_store/controllers/rewards_controller.dart';
import 'package:bizreh_paints_store/views/rewards/discounts_section.dart';
import 'package:bizreh_paints_store/views/rewards/points_section.dart';
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
          bottom: TabBar(
            tabs: [
              Tab(text: tr('rewards.discounts_tab')),
              Tab(text: tr('rewards.points_tab')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DiscountsTab(ctrl: ctrl),
            PointsRulesTab(ctrl: ctrl),
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
      appBar: CommonAppBar(title: Text(tr('rewards.discounts_tab'))),
      body: SafeArea(child: DiscountsTab(ctrl: ctrl)),
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
      appBar: CommonAppBar(title: Text(tr('rewards.points_tab'))),
      body: SafeArea(child: PointsRulesTab(ctrl: ctrl)),
    );
  }
}
