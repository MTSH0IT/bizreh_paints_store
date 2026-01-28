import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../all_gifts_view.dart';
import 'available_gift_card.dart';
import 'gifts_empty_state.dart';

class AvailableGiftsTab extends StatelessWidget {
  final GiftsController ctrl;

  const AvailableGiftsTab({
    super.key,
    required this.ctrl,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrl.isLoadingAvailable.value && ctrl.availableGifts.isEmpty) {
        return const BuildProgressIndicator();
      }

      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (ctrl.availableGifts.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: GiftsEmptyState(
                title: 'No available gifts',
                subtitle: 'Try again later.',
              ),
            )
          else
            ...ctrl.availableGifts.map((gift) {
              final giftId = gift.id ?? 0;
              return AvailableGiftCard(
                gift: gift,
                isRedeeming: ctrl.redeemingGiftId.value == giftId,
                onRedeem: giftId == 0 ? null : () => ctrl.redeemGift(giftId),
              );
            }),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Gifts',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (ctrl.gifts.isEmpty) {
                      ctrl.loadGifts();
                    }
                    Get.to(() => const AllGiftsView());
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    });
  }
}
