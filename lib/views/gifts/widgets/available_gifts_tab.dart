import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'available_gift_card.dart';
import 'gifts_empty_state.dart';

class AvailableGiftsTab extends StatelessWidget {
  final GiftsController ctrl;

  const AvailableGiftsTab({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrl.isLoadingAvailable.value && ctrl.availableGifts.isEmpty) {
        return const BuildProgressIndicator();
      }
      if (ctrl.availableGifts.isEmpty) {
        return Center(
          child: GiftsEmptyState(
            title: 'No available gifts',
            subtitle: 'Try again later.',
          ),
        );
      }

      return ListView.builder(
        //physics: const BouncingScrollPhysics(),
        itemCount: ctrl.availableGifts.length,
        itemBuilder: (context, index) {
          final gift = ctrl.availableGifts[index];
          final giftId = gift.id ?? 0;
          final giftTitle = gift.title ?? '';
          final giftPoints = gift.points ?? 0;

          return AvailableGiftCard(
            gift: gift,
            isRedeeming: ctrl.redeemingGiftId.value == giftId,
            onRedeem: giftId == 0
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                        title: 'Confirm Gift Redemption',
                        message:
                            'Are you sure you want to redeem "$giftTitle" for $giftPoints points?',
                        confirmText: 'Confirm',
                        cancelText: 'Cancel',
                        onConfirm: () => ctrl.redeemGift(giftId),
                      ),
                    );
                  },
          );
        },
      );
    });
  }
}
