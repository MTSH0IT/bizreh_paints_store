//view
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/app_refresh_wrapper.dart';
import 'package:get/get.dart';

import 'widgets/available_points_card.dart';
import 'widgets/gifts_tab_switch.dart';
import 'widgets/available_gifts_tab.dart';
import 'widgets/my_gifts_tab.dart';
import 'widgets/all_gifts_section.dart';

class GiftsView extends StatelessWidget {
  const GiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GiftsController>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Obx(
                  () => AvailablePointsCard(points: ctrl.availablePoints.value),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => GiftsTabSwitch(
                    index: ctrl.tabIndex.value,
                    onChanged: ctrl.setTab,
                  ),
                ),
                AllGiftsSection(ctrl: ctrl),
                Expanded(
                  child: AppRefreshWrapper(
                    onRefresh: ctrl.loadAll,
                    child: Obx(() {
                      final tabIndex = ctrl.tabIndex.value;
                      if (tabIndex == 0) {
                        return AvailableGiftsTab(ctrl: ctrl);
                      }
                      return MyGiftsTab(ctrl: ctrl);
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
