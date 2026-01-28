import 'package:bizreh_paints_store/controllers/gifts_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gifts_empty_state.dart';
import 'my_gift_item.dart';

class MyGiftsTab extends StatelessWidget {
  final GiftsController ctrl;

  const MyGiftsTab({
    super.key,
    required this.ctrl,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrl.isLoadingMyGifts.value && ctrl.myGifts.isEmpty) {
        return const BuildProgressIndicator();
      }

      if (ctrl.myGifts.isEmpty) {
        return const GiftsEmptyState(
          title: 'No gifts yet',
          subtitle: 'Your redeemed gifts will appear here.',
        );
      }

      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: ctrl.myGifts.length,
        itemBuilder: (context, index) {
          final item = ctrl.myGifts[index];
          return MyGiftItem(item: item);
        },
      );
    });
  }
}
