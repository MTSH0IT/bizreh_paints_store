import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/controllers/points_controller.dart';
import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bizreh_paints_store/views/gifts/gift_details_view.dart';
import 'package:bizreh_paints_store/views/orderDetails/order_details_view.dart';
import 'widgets/points_balance_card.dart';
import 'widgets/points_history_item.dart';

class EranedPointsView extends StatelessWidget {
  const EranedPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PointsController>();
    final orderCtrl = Get.find<OrderController>();
    final giftsCtrl = Get.find<GiftsController>();

    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'points.title'),
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
                  tr('points.history'),
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
                        final isSpent =
                            (item.pointsType ?? '').toLowerCase() == 'spent';
                        final isEarned = !isSpent;
                        final orderId =
                            item.orderDetails?.orderId ?? item.referenceId ?? 0;
                        final giftId =
                            item.giftDetails?.giftId ?? item.referenceId ?? 0;
                        final hasOrderTarget = isEarned && orderId > 0;
                        final hasGiftTarget = isSpent && giftId > 0;

                        return PointsHistoryItem(
                          item: item,
                          onTap: (hasOrderTarget || hasGiftTarget)
                              ? () {
                                  if (hasOrderTarget) {
                                    orderCtrl.loadOrderDetails(orderId);
                                    Get.to(() => const OrderDetailsView());
                                    return;
                                  }
                                  if (hasGiftTarget) {
                                    giftsCtrl.loadGiftById(giftId);
                                    Get.to(() => GiftDetailsView());
                                  }
                                }
                              : null,
                        );
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
