import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/points_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/points_balance_card.dart';
import 'widgets/points_history_item.dart';

class EranedPointsView extends StatelessWidget {
  const EranedPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PointsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('points.title'.tr()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        final isLoadingPoints = ctrl.isLoadingPoints.value;
        final isLoadingHistory = ctrl.isLoadingHistory.value;

        final points = ctrl.points.value;

        if (isLoadingPoints && points == null) {
          return const BuildProgressIndicator();
        }

        return Column(
          children: [
            const SizedBox(height: 12),
            PointsBalanceCard(
              balance: points?.balance ?? 0,
              totalEarned: points?.totalEarned ?? 0,
              totalSpent: points?.totalSpent ?? 0,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'points.history'.tr(),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: isLoadingHistory && ctrl.history.isEmpty
                  ? const BuildProgressIndicator()
                  : ListView.builder(
                      itemCount: ctrl.history.length,
                      itemBuilder: (context, index) {
                        final item = ctrl.history[index];
                        return PointsHistoryItem(item: item);
                      },
                    ),
            ),
            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }
}
