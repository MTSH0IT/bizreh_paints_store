import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import 'gifts_empty_state.dart';
import 'my_gift_item.dart';

class MyGiftsTab extends StatelessWidget {
  final GiftsController ctrl;

  const MyGiftsTab({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrl.isLoadingMyGifts.value && ctrl.myGifts.isEmpty) {
        return const BuildProgressIndicator();
      }

      if (ctrl.myGifts.isEmpty) {
        return Center(
          child: GiftsEmptyState(
            title: 'gifts.no_gifts_yet'.tr(),
            subtitle: 'gifts.redeemed_gifts_appear_here'.tr(),
          ),
        );
      }

      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: ctrl.myGifts.length,
        itemBuilder: (context, index) {
          final item = ctrl.myGifts[index];
          return MyGiftItem(item: item);
        },
      );
    });
  }
}
