import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/confirmation_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import 'available_gift_card.dart';
import 'gifts_empty_state.dart';

class AvailableGiftsTab extends StatelessWidget {
  final GiftsController ctrl;

  const AvailableGiftsTab({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrl.isLoadingAvailable.value && ctrl.availableGifts.isEmpty) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [SizedBox(height: 120), BuildProgressIndicator()],
        );
      }
      if (ctrl.availableGifts.isEmpty) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 120),
            Center(
              child: GiftsEmptyState(
                title: tr('gifts.no_available_gifts'),
                subtitle: tr('gifts.try_again_later'),
              ),
            ),
          ],
        );
      }

      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
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
                        title: tr('gifts.confirm_redemption'),
                        message: tr(
                          'gifts.confirm_redemption_message',
                          args: [giftTitle, '$giftPoints'],
                        ),
                        confirmText: tr('gifts.confirm'),
                        cancelText: tr('gifts.cancel'),
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
