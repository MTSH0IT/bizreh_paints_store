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
        return const BuildProgressIndicator();
      }
      if (ctrl.availableGifts.isEmpty) {
        return Center(
          child: GiftsEmptyState(
            title: 'gifts.no_available_gifts'.tr(),
            subtitle: 'gifts.try_again_later'.tr(),
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
                        title: 'gifts.confirm_redemption'.tr(),
                        message: 'gifts.confirm_redemption_message'
                            .tr()
                            .replaceAll('{0}', '"$giftTitle"')
                            .replaceAll('{1}', '$giftPoints'),
                        confirmText: 'gifts.confirm'.tr(),
                        cancelText: 'gifts.cancel'.tr(),
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
